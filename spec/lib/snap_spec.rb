require 'spec_helper'
require 'snapstats'

RSpec.describe Snapstats, "Snapstats lib logic" do
  context "fetch collected data" do

    before(:all) do
      @redis = Redis.new # default to localhost

      # 
      # 1. Create Redis Test Data
      # 2. Cleanup Redis Test Data
      #
    end

    it "fetch main report data" do
      report = Snapstats::Report::Main.new(db: @redis)
      data = report.data

      expect(data).to be_a Hash
      expect(data[:uniqs]).to be_a Integer
      expect(data[:clicks_per_day]).to be_a Integer
      expect(data[:platforms]).to be_a Hash
      expect(data[:browsers]).to be_a Hash
      expect(data[:top_pathes]).to be_a Array
    end

    it "fetch main report chart" do
      report = Snapstats::Report::Main.new(db: @redis)
      chart = report.chart

      expect(chart).to be_a Array
      expect(chart.first).to be_a Hash
    end

  end
end
