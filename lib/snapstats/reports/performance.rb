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
        @redis.zrevrangebyscore(mday("performance:max_render_time"), '+inf', '-inf', { withscores: true  }).map do |i|

          { date: i[1].to_i, value: i[0] }
        end
      end

      def chart_complex

        legend = []

        data = @redis.zrevrangebyscore(mday("performance:complex_render_time"), '+inf', '-inf', { withscores: true  }).map do |i|

          dat = JSON.parse(i[0])
          legend = dat.keys unless legend.present?

          dat.map { |k, v|
            { date: i[1].to_i, value: v }
          }
        end

        { data: data.select{ |i| i.count == legend.count }.transpose, legend: legend }
      end

    end
  end
end
