BlueTroll::Application.routes.draw do
  resources :crews

  root 'crews#index'
end
