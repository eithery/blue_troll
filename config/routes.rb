BlueTroll::Application.routes.draw do
  resources :sessions, only: [:new, :create, :destroy]
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'


  resources :user_accounts, only: [:new, :create, :show]
  resources :crews, only: [:index, :show]

  resources :participants, except: [:show] do
    collection do
      post :search
      get :adults, :children, :babies
      get :adults_onsite, :children_onsite, :babies_onsite
      get :total_registered, :total_onsite
      get :expected, :flagged
    end
  end


  scope controller: :participants, path: 'export' do
    post 'crew/:crew_id/participants/paid', action: :export_paid_by_crew, as: 'crew_paid_participants_export'
    get 'participants/awaiting', action: :export_awaiting_participants, as: 'awaiting_participants_export'
    get 'participants/with_email', action: :export_participants_with_email, as: 'participants_with_email_export'
  end


  get 'approve', to: 'participants#approve'
  get 'request_to_activate', to: 'user_accounts#request_to_activate'
  get 'activate', to: 'user_accounts#activate_by_link'
  post 'activate', to: 'user_accounts#activate'
  get 'change_password', to: 'user_accounts#change_password'
  put 'change_password', to: 'user_accounts#update_password'
  put 'select_crew', to: 'user_accounts#update_crew'

  put 'send_payment', to: 'payments#send_payment'
  post 'confirm_payment', to: 'payments#confirm_payment'

  get 'cant_access', to: 'password_reset#collect_info'
  post 'send_reset_link', to: 'password_reset#send_link'
  get 'pwd_reset', to: 'password_reset#reset'

  get 'statistics', to: 'static_pages#statistics'
  get 'announcement', to: 'static_pages#event_announcement'

  scope controller: :tickets, path: 'tickets/download' do
    post 'crew/:crew_id', action: :download_for_crew, as: 'crew_tickets_download'
    post 'user/:user_account_id', action: :download_for_user, as: 'user_tickets_download'
    match ':ticket_code', action: :download, as: 'ticket_download', via: [:get, :post]
    post 'send_link/:participant_id', action: :send_link, as: 'send_ticket_link'
  end

  controller :gate do
    get 'checkin', action: :checkin, as: 'checkin'
    post 'checkin', action: :checkin_ticket, as: 'checkin_ticket'
  end

  get 'signup', to: 'user_accounts#new'
  root 'static_pages#home'
end
