class UserAccountsController < ApplicationController
  before_action :set_user_account, only: [:show ]

  def new
    @user = UserAccount.new
  end


  def create
    @user = UserAccount.new(user_account_params)
    if @user.save
      flash[:success] = "New user account for #{@user.name} has been created"
      UserAccountsMailer.registered(@user).deliver
      redirect_to request_to_activate_path(account_id: @user.id)
    else
      render :new
    end
  end


  def show
  end


  def request_to_activate
    @user = UserAccount.find(params[:account_id])
  end


  def activate
    user_id = params[:activation][:user_account]
    activation_code = params[:activation][:code].strip
    user = UserAccount.find(user_id)
    return valid_activation user if user.activate(activation_code)

    flash[:danger] = "Invalid activation code"
    redirect_to request_to_activate_path(account_id: user.id)
  end


  def activate_by_link
    activation_token = params[:activation_token]
    user = UserAccount.find_by_activation_token(activation_token)
    return valid_activation user if user && user.activate(activation_token)

    flash[:danger] = "Invalid or expired activation link"
    redirect_to root_path
  end


private
  def set_user_account
    @user = UserAccount.find(params[:id])
  end


  def user_account_params
    params.require(:user_account).permit(:id, :login, :email, :email_confirmation, :password, :password_confirmation,
      :remember_token, :activation_token)
  end


  def valid_activation(user)
    flash[:success] = "Congratulation, #{user.name}! Your account has been successfully activated"
    redirect_to signin_path
  end
end
