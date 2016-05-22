module Snapstats
  module Report
    class Performance < Snapstats::Helpers::Base
      
      def self.data
        {
          
        }
      end

      def self.chart
        Snapstats.redis.hgetall(mday("cpd_chart")).map{ |k,v| 
          { date: k, value: v } 
        }
      end

    end
  end
end
