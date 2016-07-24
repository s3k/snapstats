require 'spec_helper'
require 'snapstats'

RSpec.describe Snapstats, "Snapstats lib logic" do
  context "fetch collected data" do

    before(:all) do
      @redis = Redis.new # default to localhost
    end

    it "fetch main report" do
      report = Snapstats::Report::Main.new(db: @redis)
      data = report.data

      expect(data).to be_a Hash
      expect(data[:uniqs]).to be_a Integer
      expect(data[:clicks_per_day]).to be_a Integer
      expect(data[:platforms]).to be_a Hash
      expect(data[:browsers]).to be_a Hash
      expect(data[:top_pathes]).to be_a Array
    end

  end
end
