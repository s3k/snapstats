module Snapstats
	class UsersController < ApplicationController

		def index
			
		end

		def show
			@users = EventReader::UserActivity.fetch_all
		end

	end
end