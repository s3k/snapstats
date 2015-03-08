Snapstats::Engine.routes.draw do
	
	root to: 'mains#show'

	resource :main do
		collection do
			get :chart
		end
	end

	resource :performance
	resource :user
end
