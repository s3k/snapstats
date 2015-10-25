module Snapstats
	class MainsController < ApplicationController

		def show
			@uniqs 			= EventReader::Uniqs.fetch_uniqs
			@clicks 		= EventReader::Cpm.fetch_all_hash
			@platforms 	= EventReader::Browsers.fetch_platforms
			@browsers 	= EventReader::Browsers.fetch_browsers

			@top_pathes 	= EventReader::Top.fetch_pathes.take(10)
			@top_browsers = EventReader::Top.fetch_browsers#.take(10)
			@top_devices 	= EventReader::Top.fetch_devices#.take(10)

			@avalible_months = EventReader::Common.fetch_avalible_months
		end

		def chart
			data = EventReader::Cpm.fetch_all_chart
			render json: data
		end

		def unavailable
			
		end

	end
end

