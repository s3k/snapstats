module Snapstats
	class PerformancesController < ApplicationController

		def index
			
		end

		def show
			@controllers = Snapstats::EventReader::Performance.fetch_slowest_controllers
		end

		def chart
			data = Snapstats::EventReader::Activity.fetch_all_chart
			render json: {data: data.values, legend: data.keys}
		end

	end
end