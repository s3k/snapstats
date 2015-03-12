Snapstats::Engine.routes.draw do
	
	root to: 'mains#show'

	resource :main do
		collection do
			get :chart
			get :unavailable
		end
	end

	resource :performance do
		collection do
			get :chart
			get :flat_chart
		end
	end
	
	resource :user do
		collection do
			get 'activity/:id' 				=> 'users#activity', :as => :activity
			get 'activity/:id/chart' 	=> 'users#chart', :as => :chart
		end
	end

	resource :reports

end
