class UserAccountsController < ApplicationController
  def new
    @user_account = UserAccount.new
  end


  def show
    @user_account = UserAccount.find(params[:id])
  end


  def create
    @user_account = UserAccount.new(user_account_params)
    if @user_account.save
      flash[:success] = "Welcome to Blue Troll application!"
      redirect_to request_to_activate_path(account_id: @user_account.id)
    else
      render 'new'
    end
  end


  def request_to_activate
    @user_account = UserAccount.find(params[:account_id])
  end


  def activate
    flash[:success] = "User account has been successfully activated."
    redirect_to signin_path
  end


private
  def user_account_params
    params.require(:user_account).permit(:id, :login, :email, :email_confirmation, :password, :password_confirmation,
      :remember_token)
  end
end
