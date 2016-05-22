module Snapstats
  module Helpers
    
    class ReportBase
      include Snapstats::Helpers::Redis

      def initialize
        @redis = Snapstats.redis
      end
    end

  end
end
