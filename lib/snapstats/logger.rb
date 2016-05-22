module Snapstats

  class Logger < Snapstats::Helpers::Base
    
    extend Snapstats::LoggerExt
    include Snapstats::LoggerStoreData

    def call name, started, finished, unique_id, payload
      return nil if payload[:controller].scan(/^Snapstats/ui).present?

      @payload = payload
      @payload[:render_time] = finished - started
      @user_agent = UserAgent.parse(@payload[:user_agent])

      store_tops
      store_daily_platforms
      store_daily_browsers

      # Main method for uniq, depends for methods upthere
      store_uniq_client_ids

      store_cpm
      store_daily_activity
      # store_daily_uniqs

      store_user_activity_table
      store_slowest_controller
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
