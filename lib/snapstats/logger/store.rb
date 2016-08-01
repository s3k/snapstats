module Snapstats

  class Store
    include Snapstats::Helper::Redis

    def initialize opt={}
      @redis = opt[:db]
      @payload = opt[:payload]
      @time_key = Time.now.to_i
    end

    def call
      store_path_and_device
      store_cpm
      # store_daily_activity
      store_user_activity

      store_user_activity_table
      store_slowest_controller
      store_performance

      # Main method for uniq, depends for methods upthere
      store_uniq_client_ids
    end

    def store_cpm
      @redis.hincrby mday("cpm"), Time.now.beginning_of_minute.to_i, 1
      @redis.incr mday("cpd")
      @redis.hincrby mday("cpd_chart"), floor_time(Time.now.to_i, 10.minutes), 1
    end

    def store_daily_activity

      # DEPRECATED

      rt_hash = @payload.keys.select{ |i| i.to_s.scan(/runtime/ui).present? }.reduce({}){ |sum, i| sum[i.to_s.gsub(/_runtime/ui, '').to_sym] = @payload[i].to_f.round(3); sum }

      value = {
        path:  @payload[:path],
        ctrl:  @payload[:controller],
        actn:  @payload[:action],
        rntm:  rt_hash,
        os:    user_agent.platform,
        brwsr: user_agent.browser,
        brver: user_agent.version.to_s,
        ip:    @payload[:ip],
        total: rt_hash.values.reduce(:+),
        email: @payload[:user_email],
        date: @time_key
      }.to_json

      @redis.zadd mday('activity'), @time_key, value
    end

    def store_performance

      rt_hash = @payload.keys.select{ |i| i.to_s.scan(/runtime/ui).present? }.reduce({}){ |sum, i| sum[i.to_s.gsub(/_runtime/ui, '').to_sym] = @payload[i].to_f.round(3); sum }

      ftime = floor_time(@time_key, 10.minutes)
      render_time = @payload[:render_time]
      rkey = mday('performance:max_render_time')
      complex_key = mday('performance:complex_render_time')

      # Set max time for key
      if @redis.zrangebyscore(rkey, ftime, ftime).first.to_f < render_time.to_f
        @redis.zadd rkey, ftime, @payload[:render_time]
        @redis.zadd complex_key, ftime, rt_hash.to_json
      end
    end

    def store_user_activity
      if @payload[:user_id].present? && @payload[:user_email].present?

        uvalue = {
          ts:     @time_key,
          path:   @payload[:path],
          total:  @payload[:render_time],
          os:     user_agent.platform,
          brwsr:  user_agent.browser,
          brver:  user_agent.version.to_s

        }.to_json

        @redis.zadd mday("activity:user:#{@payload[:user_id]}"), @time_key, uvalue
      end
    end

    def store_uniq_client_ids
      # uniq client hash table with visits
      @redis.hincrby mday('uniq_client_ids'), uniq_client_hash, 1
    end

    def store_path_and_device

      @redis.zincrby mday('pathes'), 1, @payload[:path]

      unless @redis.hexists(mday('uniq_client_ids'), uniq_client_hash)
        @redis.hincrby mday('platforms'), user_agent.platform, 1
        @redis.hincrby mday('browsers'), "#{user_agent.browser} #{user_agent.version}", 1
      end

    end

    # User activity

    def store_user_activity_table
      return nil unless @payload[:user_id].present?

      value = {
        ts:     Time.current.to_i,
        path:   @payload[:path],
        email:  @payload[:user_email]
      }.to_json

      @redis.hset mday("activity:users"), @payload[:user_id], value
    end

    # Performance

    def store_slowest_controller

      value = {
        ctrl:  @payload[:controller],
        actn:  @payload[:action],
      }.to_json

      @redis.zadd mday('performance:controllers'), @payload[:render_time].to_f, value
    end

    private

    def uniq_client_hash
      @uniq_client_hash ||= Digest::SHA1.hexdigest({

        os:    user_agent.platform,
        brwsr: user_agent.browser,
        brver: user_agent.version.to_s,
        ip:    @payload[:ip]

      }.values.join(''))
    end

    def user_agent
      @user_agent ||= UserAgent.parse(@payload[:user_agent])
    end
  end

end
