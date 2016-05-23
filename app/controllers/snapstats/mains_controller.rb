module Snapstats
	class MainsController < ApplicationController

		before_action :load_report

		def show
			@daily_report = @report.data
			# @report = Snapstats::Report::Main.new.data
		end

		def chart
			render json: @report.chart
		end

		def unavailable
			
		end

		private

		def load_report
			@report = Snapstats::Report::Main.new
		end

	end
end

