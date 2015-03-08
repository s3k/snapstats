module Snapstats
	
	def self.redis
		@@redis ||= Redis.new(:host => 'localhost', :port => 6379)
	end

	def self.mkey name
		"snaps:#{name}"
	end

	def self.mtime name
		"snaps:#{Time.now.to_i}:#{name}"
	end

	def self.mday name
		"snaps:#{DateTime.current.beginning_of_day.to_i}:#{name}"
	end

end