module Snapstats

  # 
  # ! NOT THREAD SAFE !
  # 

  def self.redis
    # Thread.current[:snap_redis] ||= nil # ||= Redis.new(:host => 'localhost', :port => 6379)
    @@snap_redis ||= nil
  end

  def self.set_redis opt={}
    # Thread.current[:snap_redis] = Redis.new( opt.present? ? opt : { :host => 'localhost', :port => 6379 } )
    @@snap_redis = Redis.new( opt.present? ? opt : { :host => 'localhost', :port => 6379 } )
  end

  def self.mkey name
    "snaps:#{name}"
  end

  def self.mtime name
    "snaps:#{Time.now.to_i}:#{name}"
  end

  def self.mday name
    current_day = Date.current.strftime('%Y%m%d')
    "snaps:#{current_day}:#{name}"
  end

end
