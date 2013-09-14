BlueTroll::Application.routes.draw do
  get "static_pages/home"
  resources :crews
  get 'ticket', to: 'tickets#create'
  root 'crews#index'
end
