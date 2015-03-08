module Snapstats
	class MainsController < ApplicationController

		def show
			@uniqs = EventReader::Uniqs.fetch_uniqs
			@clicks = EventReader::Cpm.fetch_all_hash
		end

		def chart
			data = [{date: Time.now.beginning_of_day.to_i, value: 0}] + (EventReader::Cpm.fetch_all_chart) + [{date: Time.now.to_i, value: 0}]
			render json: data
		end

	end
end

