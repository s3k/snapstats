module Snapstats
  module Report
    class Main < Snapstats::Helpers::ReportBase
      
      def data
        {
          uniqs: @redis.hlen(mday("uniq_client_ids")).to_i,
          clicks_per_minute: @redis.hget(mday("cpm"), Time.now.beginning_of_minute.to_i).to_i,
          clicks_per_day: @redis.get(mday("cpd")).to_i,
          
          platforms:  @redis.hgetall(mday("platforms")),
          browsers:   @redis.hgetall(mday("browsers")),
          top_pathes: (@redis.zrevrangebyscore mday('top:pathes'), "+inf", "-inf", :with_scores => true, limit: [0, 10])
        }
      end

      def chart
        @redis.hgetall(mday("cpd_chart")).map{ |k,v| 
          { date: k, value: v } 
        }
      end

    end
  end
end
