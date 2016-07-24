class TestRedis

  attr_accessor :redis

  def initialize
    self.redis = MockRedis.new 
    @current_day = Date.current.strftime('%Y%m%d')
  end

  def load_main_report
    self.redis.hincrby "snaps:#{@current_day}:uniq_client_ids", "uniq_hash_1", 1
  end

end
