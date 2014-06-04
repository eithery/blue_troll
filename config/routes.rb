BlueTroll::Application.routes.draw do
  resources :user_accounts, only: [:new, :create, :show]
  resources :crews, only: [:index, :show]
  resources :sessions, only: [:new, :create, :destroy]

  resources :participants, except: [:show] do
    post :search, on: :collection
  end

  get 'request_to_activate', to: 'user_accounts#request_to_activate'
  get 'activate', to: 'user_accounts#activate_by_link'
  post 'activate', to: 'user_accounts#activate'
  get 'change_password', to: 'user_accounts#change_password'
  put 'change_password', to: 'user_accounts#update_password'
  put 'select_crew', to: 'user_accounts#update_crew'

  put 'send_payment', to: 'payments#send_payment'
  post 'confirm_payment', to: 'payments#confirm_payment'

  get 'upload_participants', to: 'uploads#select_participants_file'
  post 'upload_participants', to: 'uploads#upload_participants'

  get 'cant_access', to: 'password_reset#collect_info'
  post 'send_reset_link', to: 'password_reset#send_link'
  get 'pwd_reset', to: 'password_reset#reset'

  get 'statistics', to: 'static_pages#statistics'
  get 'approve', to: 'participants#approve'
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

  controller :tickets, path: 'tickets/download' do
    post 'crew/:crew_id', to: :download_for_crew, as: 'crew_tickets_download'
    post 'user/:user_account_id', to: :download_for_user, as: 'user_tickets_download'
    match ':ticket_code', to: :download, as: 'ticket_download', via: [:get, :post]
    post 'send_link/:participant_id', to: :send_link, as: 'send_ticket_link'
  end

  controller :gate do
    get 'checkin', to: :checkin, as: 'checkin'
    post 'checkin', to: :checkin_ticket, as: 'checkin_ticket'
  end

  get 'signup', to: 'user_accounts#new'
  get 'signin', to: 'sessions#new'
  match 'signout', to: 'sessions#destroy', via: :delete

  root 'static_pages#home'
end
