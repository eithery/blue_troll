BlueTroll::Application.routes.draw do
  resources :crews

  get 'tickets/download'

  root 'crews#index'
end
