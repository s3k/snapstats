class TestRedis

  attr_accessor :redis

  def initialize
    @redis = MockRedis.new 
  end

  def create_test_data
    payload = JSON.parse "{\"controller\":\"MainController\",\"action\":\"index\",\"params\":{\"controller\":\"main\",\"action\":\"index\"},\"format\":\"html\",\"method\":\"GET\",\"path\":\"/\",\"ip\":\"127.0.0.1\",\"stash\":null,\"user_id\":1,\"user_email\":\"admin@admin.local\",\"user_agent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_5) AppleWebKit/601.6.17 (KHTML, like Gecko) Version/9.1.1 Safari/601.6.17\",\"status\":200,\"view_runtime\":5.6129999999999995,\"db_runtime\":1.716,\"render_time\":0.006288}"

    Snapstats::Store.new(payload: payload, db: @redis).call
  end

end
