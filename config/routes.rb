BlueTroll::Application.routes.draw do
  resources :crews
  get 'ticket', to: 'tickets#create'
  root 'crews#index'
end
