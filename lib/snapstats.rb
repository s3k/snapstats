require 'digest/sha1'
require "snapstats/engine"
require "snapstats/redis"

# Helpers
require "snapstats/helpers/redis"
require "snapstats/helpers/report"

# Loggers
require "event_logger/event_logger"

# Reports
require "snapstats/reports/main"
require "snapstats/reports/user"
require "snapstats/reports/performance"

# require "snapstats/model/main"
# require "event_reader/event_reader"
# require "snapstats/event_logger"

module Snapstats
  
  # 
  # Example params
  # 
  # :devise_model       => { :model => :user, :login_fields => [:email, :username] }, 
  # :redis              => { :host => 'localhost', :port => 6379 }, 
  # :disable_logging    => false 
  # 

	def self.start opt={}
    EventLogger.start opt
  end
end
