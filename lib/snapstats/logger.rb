module Snapstats

  class Logger
    extend Snapstats::LoggerExt

    def call name, started, finished, unique_id, payload
      return nil if payload[:controller].scan(/^Snapstats/ui).present?

      @payload = payload
      @payload[:render_time] = finished - started

      # Store to redis
      Snapstats::Store.new(payload: @payload, db: Snapstats.redis).call
    end

  end

end
