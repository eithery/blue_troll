BlueTroll::Application.routes.draw do
  resources :crews
  resources :participants
  resources :users

  # Tickets generator.
  get 'ticket', to: 'tickets#create'
  get 'crew_tickets', to: 'tickets#generate_crew_tickets'
  get 'participant_ticket', to: 'tickets#generate_participant_ticket'

  # Check in page.
  get 'checkin', to: 'registration#checkin'
  post 'checkin', to: 'registration#check_ticket'

  # Administration tasks.
  get 'upload', to: 'upload#select_file'
  post 'upload', to: 'upload#upload_file'

  # Static pages.
  get 'statistics', to: 'static_pages#statistics'

  # Root home page.
  root 'static_pages#home'
end
