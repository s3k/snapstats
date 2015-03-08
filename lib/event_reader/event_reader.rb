module Snapstats
	module EventReader
		
		class Activity
			include Virtus.model

			attribute :email, String
      attribute :path, String
      attribute :controller, String
      attribute :action, String
      attribute :runtimes, Array
      attribute :os, String
      attribute :browser, String
      attribute :version, String
      attribute :ip, String
      attribute :render_time, String


			def self.fetch from=0, to=-1
				Snapstats.redis.zrange(Snapstats.mday("activity"), 0, -1).map do |i|
					v = JSON.parse(i, :symbolize_names => true)
					
					self.new(email: v[:email], 
									path: v[:path], 
									controller: v[:cntrl], 
									action: v[:actn], 
									runtimes: v[:rntm], 
									os: v[:os], 
									browser: v[:brwsr], 
									version: v[:brver],
									ip: v[:ip],
									render_time: v[:total])
				end 
			end
      
		end

		class Uniqs
			include Virtus.model

			def self.fetch_uniqs
				Snapstats.redis.hgetall(Snapstats.mday("uniq")).values.reduce(:+)
			end
		end

		class Cpm
			include Virtus.model

			def self.fetch_cpm 
				Snapstats.redis.hget(Snapstats.mday("cpm"), Time.now.beginning_of_minute.to_i)
			end

			def self.fetch_cph
				Snapstats.redis.hgetall(Snapstats.mday("cpm"))
			end

			def self.fetch_cpd
				Snapstats.redis.hgetall(Snapstats.mday("cpm")).values.reduce(:+)
			end


			def self.fetch_all
				Snapstats.redis.hgetall(Snapstats.mday("cpm"))
			end

			def self.fetch_all_hash
				data = Snapstats.redis.hgetall(Snapstats.mday("cpm"))

				cpm = data[Time.now.beginning_of_minute.to_i.to_s] || 0
				cph = data.group_by{ |k, v| Time.at(k.to_i).beginning_of_hour }.reduce({}){|sum, (k, v)| sum[k] = v.map{|i| i.last.to_i}.reduce(:+); sum }
				cpd = data.values.reduce(0){ |sum, i| sum + i.to_i }

				{ cpm: cpm, cph: cph[Time.now.beginning_of_hour], cpd: cpd }
			end

			def self.fetch_all_chart
				fetch_all.map{ |k ,v| { date: k, value: v } }
			end
      
		end

		class UserActivity
			include Virtus.model

			attribute :email, String
			attribute :date, Time
			attribute :path, String

			def self.fetch_all
				Snapstats.redis.hgetall("snaps:activity:users").map do |email, values|
					values = JSON.parse(values, :symbolize_names => true)
					self.new(email: email, date: Time.at(values[:ts]), path: values[:path])
				end
			end

		end

	end
end