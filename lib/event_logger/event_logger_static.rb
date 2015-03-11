module Snapstats

  class EventLogger

  	@@is_started = false

    def self.start opt={}
    	unless @@is_started

				Snapstats.set_redis opt[:redis]

				unless opt[:disable_logging] == true
		    	init_events opt
		    	subscribe 
		    end

	    	@@is_started = true
	    end
    end

    def self.subscribe
    	ActiveSupport::Notifications.subscribe('process_action.action_controller', self.new)
    end

    def self.init_events opt={}
    	
			ActionController::Instrumentation.send(:define_method, "process_action") do |arg|

				fetch_user_id = -> params { 
					model = params.try(:[], :devise_model).try(:[], :model) || :user
					request.env['warden'].try(model.to_sym).try(:id)
				}

				fetch_user_email = -> params {
					model = params.try(:[], :devise_model).try(:[], :model) || :user

					if params[:devise_model].present? && params[:devise_model].try(:[], :login_fields).present?
						return params[:devise_model][:login_fields].map{ |field| request.env['warden'].try(model.to_sym).try(field.to_sym) }.compact.first
					else
						return request.env['warden'].try(model.to_sym).try(:email)
					end
				}

			  raw_payload = {
			    :controller => self.class.name,
			    :action     => self.action_name,
			    :params     => request.filtered_parameters,
			    :format     => request.format.try(:ref),
			    :method     => request.method,
			    :path       => (request.fullpath rescue "unknown"),
			 
			    :ip         => request.remote_ip,
			    :stash      => request.session['flash'] && request.session['flash'][:log],
			    
			    :user_id  	=> fetch_user_id.call(opt),
			    :user_email => fetch_user_email.call(opt),
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
