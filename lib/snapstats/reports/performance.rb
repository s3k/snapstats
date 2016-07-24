module Snapstats
  module Report
    class Performance
      include Snapstats::Helper::Redis

      def initialize opt={}
        @redis = opt[:db]
      end

      def slowest_controllers
        @redis.zrevrangebyscore(mday('performance:controllers'), '+inf', '-inf', { withscores: true }).map do |i|
          v     = JSON.parse(i.first, :symbolize_names => true)
          time  = i.last

          { controller: v[:ctrl], action: v[:actn], render_time: time }
        end
      end

      def chart
        @redis.hgetall(mday("cpd_chart")).map{ |k,v| 
          { date: k, value: v } 
        }
      end

    end
  end
end
