require 'pp'
require 'digest/sha1'
require "snapstats/engine"
require "snapstats/redis"

# Helpers
require "snapstats/helper/redis"
# require "snapstats/helpers/base"

# Loggers
require "snapstats/logger/ext"
require "snapstats/logger/store_data"
require "snapstats/logger"

# Reports
require "snapstats/reports/manager"
require "snapstats/reports/main"
require "snapstats/reports/user"
require "snapstats/reports/performance"


module Snapstats
  
  # 
  # Example params
  # 
  # :devise_model       => { :model => :user, :login_fields => [:email, :username] }, 
  # :redis              => { :host => 'localhost', :port => 6379 }, 
  # :disable_logging    => false 
  # 

	def self.start opt={}
    Snapstats.redis = opt[:redis]
    Logger.start opt
  end
end
