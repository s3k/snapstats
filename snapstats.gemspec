$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "snapstats/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "snapstats"
  s.version     = Snapstats::VERSION
  s.authors     = ["s3k"]
  s.email       = ["https://github.com/s3k"]
  s.homepage    = "https://github.com/s3k"
  s.summary     = "If you want to know your slowest controllers, cpm or even user devices and browsers — welcome!"
  s.description = "With this gem you can track your user activity (devise feature only), slowest controllers, user devices and platforms. It's like newrelic, but better ;)"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails"#, "~> 4.0.2"
  s.add_dependency "redis"
  s.add_dependency "useragent"
  s.add_dependency "virtus"
end
