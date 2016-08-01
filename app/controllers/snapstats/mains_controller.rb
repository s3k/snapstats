module Snapstats
  class MainsController < ApplicationController

    before_action :load_report

    def show
      @daily_report = @report.data
    end

    def chart
      render json: @report.chart
    end

    def unavailable
    end

    private

    def load_report
      @report = Snapstats::Report::Manager.new(:main).call
    end

  end
end

