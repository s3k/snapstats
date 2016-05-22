module Snapstats

  # 
  # ! NOT THREAD SAFE !
  # 

  def self.redis
    @@snap_redis ||= nil
  end

  def self.redis= opt={}
    @@snap_redis ||= Redis.new( opt.present? ? opt : { :host => 'localhost', :port => 6379 } )
  end

end
