module Snapstats
	
  class EventLogger

  	# Daily report

    def store_cpm
      @redis.hincrby mday("cpm"), Time.now.beginning_of_minute.to_i, 1
    end

		def store_daily_activity

      time_key = Time.current.to_i

      value = { 
        path:  @payload[:path],
        ctrl:  @payload[:controller],
        actn:  @payload[:action],
        rntm:  @payload.keys.select{ |i| i.to_s.scan(/runtime/ui).present? }.map{ |i| { i.to_sym => @payload[i].to_f.round(3) } },
        os:    @user_agent.platform,
        brwsr: @user_agent.browser,
        brver: @user_agent.version.to_s,
        ip:    @payload[:ip],
        total: @payload[:render_time],
        email: @payload[:email]
      }.to_json

      @redis.zadd mday('activity'), time_key, value

      # add here links to users in sets like
  	end

    def store_daily_uniqs
      @redis.hincrby mday('uniq'), @payload[:ip], 1
    end

    def store_daily_browsers
      @redis.hset mday('uniq'), @user_agent.platform, 1
    end

  	# User activity

  	def store_user_activity_table
  		return nil unless @payload[:user_email].present?

  		value = { 
  			ts: 		Time.current.to_i, 
  			path: 	@payload[:path]
  		}.to_json

  		@redis.hset mkey("activity:users"), @payload[:user_email], value 
  	end

  	# Performance

  	def store_performance_graph
  		
  	end

  	def store_performance_table
  		
  	end

  end

end
