BlueTroll::Application.routes.draw do
  resources :crews

	get 'static_pages/home'
  get 'ticket', to: 'tickets#create'

  root 'static_pages#home'
end
