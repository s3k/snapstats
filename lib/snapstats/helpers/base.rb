module Snapstats
  module Helpers
    
    class Base
      include Snapstats::Helpers::Helper

      def initialize
        @redis = Snapstats.redis
      end
    end

  end
end
