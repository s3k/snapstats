Snapstats::Engine.routes.draw do
	
	root to: 'main#show'

	resource :main
	resource :performance
	resource :user
end
