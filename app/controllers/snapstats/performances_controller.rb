module Snapstats
	class PerformancesController < ApplicationController

		before_action :load_report

		def index
			
		end

		def show
			# @controllers = Snapstats::EventReader::Performance.fetch_slowest_controllers
			@controllers = @report.slowest_controllers
		end

		def chart
			data = Snapstats::EventReader::Activity.fetch_all_chart_scale
			render json: {data: data.values, legend: data.keys}
		end

		def flat_chart
			render json: Snapstats::EventReader::Activity.fetch_flat_chart
		end

		private

		def load_report
			@report = Snapstats::Report::Performance.new
		end

	end
end