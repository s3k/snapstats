module Snapstats
  class ApplicationController < ActionController::Base

		before_action except: [:unavailable] do |controller|
			redirect_to unavailable_main_path unless Snapstats.redis.present?
		end

  end
end
