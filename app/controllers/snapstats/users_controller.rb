module Snapstats
	class UsersController < ApplicationController
		
		def index
			
		end

		def show
			@users = EventReader::UserActivity.fetch_all
		end

		def activity
			@user_email = EventReader::UserActivity.fetch_email_by_uid params[:id]
			@activity 	= EventReader::UserActivity.fetch_for_user params[:id]
		end

		def chart
			render json: EventReader::UserActivity.fetch_chart_for_user(params[:id])
		end

	end
end