BlueTroll::Application.routes.draw do
  resources :crews

  get 'tickets/download'
  get 'ticket', to: 'tickets#create'

  root 'crews#index'
end
