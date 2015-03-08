require "snapstats/engine"
require "ext/redis"
require "event_logger/event_logger"
require "event_reader/event_reader"

module Snapstats
	EventLogger.start
end
