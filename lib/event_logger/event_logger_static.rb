module Snapstats

  class EventLogger

  	@@is_started = false

    def self.start
    	unless @@is_started
	    	
	    	init_events
	    	subscribe 

	    	@@is_started = true
	    end
    end

    def self.subscribe
    	ActiveSupport::Notifications.subscribe('process_action.action_controller', self.new)
    end

    def self.init_events
    	
			ActionController::Instrumentation.send(:define_method, "process_action") do |arg|

			  raw_payload = {
			    :controller => self.class.name,
			    :action     => self.action_name,
			    :params     => request.filtered_parameters,
			    :format     => request.format.try(:ref),
			    :method     => request.method,
			    :path       => (request.fullpath rescue "unknown"),
			 
			    :ip         => request.remote_ip,
			    :stash      => request.session['flash'] && request.session['flash'][:log],
			    
			    :user_id  	=> request.env['warden'].try(:user).try(:id),
			    :user_email => request.env['warden'].try(:user).try(:email),
			    :user_agent => request.user_agent
			  }
			 
			  ActiveSupport::Notifications.instrument("start_processing.action_controller", raw_payload.dup)
			 
			  ActiveSupport::Notifications.instrument("process_action.action_controller", raw_payload) do |payload|
			    result = super(arg)
			    payload[:status] = response.status
			    append_info_to_payload(payload)
			    result
			  end
			end

    end

  end

end
