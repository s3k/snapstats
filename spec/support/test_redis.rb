class TestRedis

  attr_accessor :redis

  def initialize
    @redis = MockRedis.new 
  end

  def create_test_data
    payload = JSON.parse "{\"controller\":\"MainController\",\"action\":\"index\",\"params\":{\"controller\":\"main\",\"action\":\"index\"},\"format\":\"html\",\"method\":\"GET\",\"path\":\"/?param=test\",\"ip\":\"127.0.0.1\",\"stash\":null,\"user_id\":1,\"user_email\":\"admin@admin.local\",\"user_agent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/601.7.7 (KHTML, like Gecko) Version/9.1.2 Safari/601.7.7\",\"status\":200,\"view_runtime\":8.447,\"db_runtime\":2.721,\"render_time\":0.009458}", symbolize_names: true

    Snapstats::Store.new(payload: payload, db: @redis).call
  end

end
