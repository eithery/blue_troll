BlueTroll::Application.routes.draw do
  get "users/new"

  resources :crews
  resources :participants

  # Tickets generator.
  get 'ticket', to: 'tickets#create'
  get 'crew_tickets', to: 'tickets#generate_crew_tickets'
  get 'participant_ticket', to: 'tickets#generate_participant_ticket'

  # Administration tasks.
  get 'upload', to: 'upload#select'
  post 'upload', to: 'upload#file_upload'

  # Root home page.
  root 'static_pages#home'
end
