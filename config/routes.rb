BlueTroll::Application.routes.draw do
  resources :user_accounts, only: [:new, :create, :show]
  resources :crews, only: [:index]
  resources :participants, except: [:show]
  resources :sessions, only: [:new, :create, :destroy]

  get 'request_to_activate', to: 'user_accounts#request_to_activate'
  get 'activate', to: 'user_accounts#activate_by_link'
  post 'activate', to: 'user_accounts#activate'
  get 'change_password', to: 'user_accounts#change_password'
  put 'change_password', to: 'user_accounts#update_password'

  get 'cant_access', to: 'password_reset#collect_info'
  post 'send_reset_link', to: 'password_reset#send_link'
  get 'pwd_reset', to: 'password_reset#reset'

  post 'search', to: 'participants#search'
  get 'flagged', to: 'participants#flagged'
  get 'adults', to: 'participants#adults'
  get 'children', to: 'participants#children'
  get 'babies', to: 'participants#babies'
  get 'total_registered', to: 'participants#total_registered'
  get 'adults_onsite', to: 'participants#adults_onsite'
  get 'children_onsite', to: 'participants#children_onsite'
  get 'babies_onsite', to: 'participants#babies_onsite'
  get 'total_onsite', to: 'participants#total_onsite'
  get 'expected', to: 'participants#expected'

  # Tickets generator.
  get 'ticket', to: 'tickets#create'
  get 'crew_tickets', to: 'tickets#generate_crew_tickets'
  get 'participant_ticket', to: 'tickets#generate_participant_ticket'

  # Check in page.
  get 'checkin', to: 'registration#checkin'
  post 'checkin', to: 'registration#check_ticket'

  # Static pages.
  get 'statistics', to: 'static_pages#statistics'

  # Authentication and user registration pages.
  get 'signup', to: 'user_accounts#new'
  get 'signin', to: 'sessions#new'
  match 'signout', to: 'sessions#destroy', via: :delete

  # Root home page.
  root 'static_pages#home'
end
