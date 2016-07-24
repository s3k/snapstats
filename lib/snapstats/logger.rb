module Snapstats

  class Logger
    extend Snapstats::LoggerExt
    include Snapstats::Helper::Redis
    include Snapstats::LoggerStoreData

    def initialize opt={db: Snapstats.redis}
      @redis = opt[:db]
    end

    def call name, started, finished, unique_id, payload
      return nil if payload[:controller].scan(/^Snapstats/ui).present?

      @payload = payload
      @payload[:render_time] = finished - started
      @user_agent = UserAgent.parse(@payload[:user_agent])

      store_path_and_device
      store_cpm
      store_daily_activity

      store_user_activity_table
      store_slowest_controller

      # Main method for uniq, depends for methods upthere
      store_uniq_client_ids
    end

    private

    def uniq_client_hash
      Digest::SHA1.hexdigest({
        
        os:    @user_agent.platform,
        brwsr: @user_agent.browser,
        brver: @user_agent.version.to_s,
        ip:    @payload[:ip]

      }.values.join(''))
    end

  end

end
