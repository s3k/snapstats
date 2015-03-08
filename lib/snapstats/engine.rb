require "redis"
require "useragent"
require "virtus"

module Snapstats
  class Engine < ::Rails::Engine
    isolate_namespace Snapstats
  end
end
