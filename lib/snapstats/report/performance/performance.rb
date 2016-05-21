module Snapstats
  module Report
    module Main
      
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
