BlueTroll::Application.routes.draw do
  resources :crews

  get 'tickets/download'
  get 'tickets/create'

  root 'crews#index'
end
