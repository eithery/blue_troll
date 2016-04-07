BlueTroll::Application.routes.draw do
  resources :sessions, only: [:new, :create, :destroy]
  resources :user_accounts, :crews
  resources :account_activations, only: [:new, :edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :participants, except: [:show]
  resources :events do
    resources :event_crews, only: [:index, :create, :update, :destroy]
    resources :event_participants, only: [:index, :create, :update, :destroy]
  end

  get 'signup' => 'user_accounts#new'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  root 'landing#index'


  scope controller: :participants, path: 'export' do
    post 'crew/:crew_id/participants/paid', action: :export_paid_by_crew, as: 'crew_paid_participants_export'
    get 'participants/awaiting', action: :export_awaiting_participants, as: 'awaiting_participants_export'
    get 'participants/with_email', action: :export_participants_with_email, as: 'participants_with_email_export'
  end


  get 'approve', to: 'participants#approve'
  put 'select_crew', to: 'user_accounts#update_crew'
  put 'send_payment', to: 'payments#send_payment'
  post 'confirm_payment', to: 'payments#confirm_payment'
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
end
