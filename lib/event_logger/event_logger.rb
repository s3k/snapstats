module Snapstats
  require "event_logger/event_logger_static"
  require "event_logger/event_logger_store"

  class EventLogger

    def initialize
      @redis = Snapstats::redis
    end

    def call name, started, finished, unique_id, payload
      return nil if payload[:controller].scan(/^Snapstats/ui).present?

      @payload = payload
      @payload[:render_time] = finished - started
      @user_agent = UserAgent.parse(@payload[:user_agent])

      store_cpm
      store_daily_activity
      store_daily_uniqs

      store_daily_platforms
      store_daily_browsers

      store_user_activity_table
      store_slowest_controller
    end

    private

    def mkey name
      Snapstats.mkey name
    end

    def mtime name
      Snapstats.mtime name
    end

    def mday name
      Snapstats.mday name
    end

  end

end
