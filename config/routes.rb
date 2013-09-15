BlueTroll::Application.routes.draw do
  resources :crews
  resources :participants

  # Tickets generator.
  get 'ticket', to: 'tickets#create'

  # Root home page.
  root 'static_pages#home'
end
