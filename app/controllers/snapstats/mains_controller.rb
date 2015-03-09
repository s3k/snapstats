module Snapstats
	class MainsController < ApplicationController

		def show
			@uniqs 			= EventReader::Uniqs.fetch_uniqs
			@clicks 		= EventReader::Cpm.fetch_all_hash
			@platforms 	= EventReader::Browsers.fetch_platforms
			@browsers 	= EventReader::Browsers.fetch_browsers
		end

		def chart
			data = EventReader::Cpm.fetch_all_chart
			render json: data
		end

	end
end

