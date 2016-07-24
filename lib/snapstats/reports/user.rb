module Snapstats
  module Report
    class User
      include Snapstats::Helper::Redis

      def initialize opt={}
        @redis = opt[:db]
      end

      def data
        @redis.hgetall(mday("activity:users")).map do |uid, values|
          values = JSON.parse(values, :symbolize_names => true)
          { email: values[:email], date: Time.at(values[:ts].to_i), path: values[:path], user_id: uid }
        end
      end

      def user_data user_id, from='+inf', to='-inf'
        @redis.zrevrangebyscore(mday("activity:user:#{user_id}"), from, to).map do |i|
          v = JSON.parse(i, :symbolize_names => true)

          { path:         v[:path],
            render_time:  v[:total],
            os:           v[:os],
            browser:      v[:brwsr],
            version:      v[:brver],
            date:         Time.at(v[:ts].to_i) }
        end
      end

      def chart user_id, aprx=10
        user_data(user_id).group_by{ |i| floor_time(i[:date].to_i, aprx.minutes) }.map{ |k, v| { date: k.to_i, value: v.count } }
        @redis.hgetall(mday("cpd_chart")).map{ |k,v| 
          { date: k, value: v } 
        }
      end

      def fetch_user_email user_id
        data = @redis.hgetall(mday("activity:users"))[user_id]
        JSON.parse(data, :symbolize_names => true)[:email] if data
      end

    end
  end
end
