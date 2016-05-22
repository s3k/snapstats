module Snapstats

  module LoggerStoreData

    def store_cpm
      @redis.hincrby mday("cpm"), Time.now.beginning_of_minute.to_i, 1
      @redis.incr mday("cpd")
      @redis.hincrby mday("cpd_chart"), floor_time(Time.now.to_i, 10.minutes), 1
    end

    def store_daily_activity

      time_key = Time.current.to_i

      rt_hash = @payload.keys.select{ |i| i.to_s.scan(/runtime/ui).present? }.reduce({}){ |sum, i| sum[i.to_s.gsub(/_runtime/ui, '').to_sym] = @payload[i].to_f.round(3); sum }

      value = {
        path:  @payload[:path],
        ctrl:  @payload[:controller],
        actn:  @payload[:action],
        rntm:  rt_hash,
        os:    @user_agent.platform,
        brwsr: @user_agent.browser,
        brver: @user_agent.version.to_s,
        ip:    @payload[:ip],
        total: rt_hash.values.reduce(:+),
        email: @payload[:user_email],
        date: time_key
      }.to_json

      @redis.zadd mday('activity'), time_key, value

      # add here links to users in sets like

      if @payload[:user_id].present? && @payload[:user_email].present?

        uvalue = {
          ts:     time_key,
          path:   @payload[:path],
          total:  @payload[:render_time],
          os:     @user_agent.platform,
          brwsr:  @user_agent.browser,
          brver:  @user_agent.version.to_s

        }.to_json

        @redis.zadd mday("activity:user:#{@payload[:user_id]}"), time_key, uvalue
      end
    end

    def store_uniq_client_ids
      # uniq client hash table with visits
      @redis.hincrby mday('uniq_client_ids'), uniq_client_hash, 1
    end

    def store_path_and_device
      
      @redis.zincrby mday('pathes'), 1, @payload[:path]

      unless @redis.hexists(mday('uniq_client_ids'), uniq_client_hash)
        @redis.hincrby mday('platforms'), @user_agent.platform, 1
        @redis.hincrby mday('browsers'), "#{@user_agent.browser} #{@user_agent.version}", 1
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

  end

end
