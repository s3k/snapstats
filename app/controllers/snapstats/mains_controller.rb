module Snapstats
	class MainsController < ApplicationController

		def show
			@report = Snapstats::Report::Main.data
		end

		def chart
			render json: Snapstats::Report::Main.chart
		end

		def unavailable
			
		end

	end
end

