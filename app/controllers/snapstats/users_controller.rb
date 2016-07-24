module Snapstats
  class UsersController < ApplicationController
    
    before_action :load_report

    def index
      
    end

    def show
      # @users = EventReader::UserActivity.fetch_all
      @users_activity = @report.data
    end

    def activity
      # @user_email = EventReader::UserActivity.fetch_email_by_uid params[:id]
      # @activity   = EventReader::UserActivity.fetch_for_user params[:id]

      @user_email = @report.fetch_user_email params[:id]
      @activity   = @report.user_data params[:id]
    end

    def chart
      render json: @report.chart(params[:id])
    end

    private

    def load_report
      @report = Snapstats::Report::Manager.new(:user).call
    end

  end
end
