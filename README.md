# Snapstats

With this gem you can track your user activity (devise feature only), slowest controllers, user browsers and platforms. It's like newrelic, but better.

How to install

1. Add in Gemfile `gem 'snapstats'`
2. In your routes.rb add `mount Snapstats::Engine, :at => '/snap' `
3. Create `initializers/snapstats.rb` and add params

```
Snapstats::EventLogger.start({ 
	:devise_model 		=> { :model => :user, :login_fields => [:email, :username] }, 
	:redis 				=> { :host => 'localhost', :port => 6379 }, 
	:disable_logging 	=> false 
})
```

Visit http://localhost:3000:/snap to see result

-----
This project rocks and uses MIT-LICENSE