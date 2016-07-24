require 'spec_helper'
require 'snapstats'
require 'mock_redis'
require 'pry'

RSpec.describe Snapstats, "Snapstats lib logic" do
  context "fetch collected data" do

    before(:all) do
      @redis = TestRedis.new
    end

    it "fetch main report data" do
      report = Snapstats::Report::Main.new(db: @redis.redis)
      data = report.data

      # binding.pry
      expect(data).to be_a Hash
      expect(data[:uniqs]).to eq 1
      expect(data[:clicks_per_day]).to be_a Integer
      expect(data[:platforms]).to be_a Hash
      expect(data[:browsers]).to be_a Hash
      expect(data[:top_pathes]).to be_a Array
    end

    it "fetch main report chart" do
      report = Snapstats::Report::Main.new(db: @redis.redis)
      chart = report.chart
      expect(chart).to be_a Array
      # expect(chart.first).to be_a Hash
    end

  end
end
