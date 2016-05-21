module Snapstats
  module Report
    module Main
      
      def self.data
        {
          uniqs: Snapstats.redis.hlen(Snapstats.mday("uniq_client_ids")).to_i,
          clicks_per_minute: Snapstats.redis.hget(Snapstats.mday("cpm"), Time.now.beginning_of_minute.to_i).to_i,
          clicks_per_day: Snapstats.redis.get(Snapstats.mday("cpd")).to_i,
          
          platforms:  Snapstats.redis.hgetall(Snapstats.mday("platforms")),
          browsers:   Snapstats.redis.hgetall(Snapstats.mday("browsers")),
          top_pathes: (Snapstats.redis.zrevrangebyscore Snapstats.mday('top:pathes'), "+inf", "-inf", :with_scores => true, limit: [0, 10])
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
