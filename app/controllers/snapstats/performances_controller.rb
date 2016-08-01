module Snapstats
  class PerformancesController < ApplicationController

    before_action :load_report

    def index
    end

    def show
      @controllers = @report.slowest_controllers
    end

    def chart
      render json: @report.chart_complex
    end

    def flat_chart
      render json: @report.chart
    end

    private

    def load_report
      @report = Snapstats::Report::Manager.new(:performance).call
    end

  end
end
