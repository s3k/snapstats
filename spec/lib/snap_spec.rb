require 'spec_helper'
require 'snapstats'
require 'mock_redis'
require 'pry'

RSpec.describe Snapstats, "Snapstats lib logic" do
  context "fetch collected data" do

    before(:all) do
      @db = TestRedis.new
      @db.create_test_data
    end

    #
    # Main page
    #

    it "fetch main report data" do
      report = Snapstats::Report::Main.new(db: @db.redis)

      expect(report.data).to be_a Hash
      expect(report.data[:uniqs]).to eq 1
      expect(report.data[:clicks_per_day]).to eq 1
      expect(report.data[:platforms]["Macintosh"]).to eq "1"
      expect(report.data[:browsers]["Safari 9.1.2"]).to eq "1"
      expect(report.data[:top_pathes]).to be_a Array
    end

    it "fetch main report chart" do
      report = Snapstats::Report::Main.new(db: @db.redis)
      expect(report.chart).to be_a Array
      expect(report.chart.first).to be_a Hash
    end

    #
    # User common page
    #

    it "fetch user data for all users" do
      report = Snapstats::Report::User.new(db: @db.redis)
      expect(report.data).to be_a Array

      item = report.data.first

      expect(item[:email]).to eq "admin@admin.local"
      expect(item[:date]).to be_a Time
      expect(item[:path]).to eq "/"
      expect(item[:user_id]).to eq "1"
    end

    #
    # User individual page
    #

    it "fetch individual user report" do
      report = Snapstats::Report::User.new(db: @db.redis)
      data = report.user_data(1)

      expect(data).to be_a Array
    end

    it "fetch individual user chart" do
      report = Snapstats::Report::User.new(db: @db.redis)
      data = report.chart(1)

      expect(data).to be_a Array
    end

    #
    # Performance page
    #

    it "fetch performance report" do
      report = Snapstats::Report::Performance.new(db: @db.redis)
      data = report.slowest_controllers

      expect(data).to be_a Array

      item = data.first

      expect(item[:controller]).to eq "MainController"
      expect(item[:action]).to eq "index"
      expect(item[:render_time]).to be_a Float
    end

    it "fetch performance chart" do
      report = Snapstats::Report::Performance.new(db: @db.redis)
      data = report.chart

      expect(data).to be_a Array

      item = data.first

      expect(item[:date]).to be_a String
      expect(item[:value]).to eq "1"
    end

  end

  context "store collected data" do
    # it "store payload" do
    # end
  end

end
