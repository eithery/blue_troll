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
      redirect_to request_to_activate_path(@user_account)
    else
      render 'new'
    end
  end


  def request_to_activate
    @user_account = UserAccount.find(params[:id])
  end


private
  def user_account_params
    params.require(:user_account).permit(:login, :email, :email_confirmation, :password, :password_confirmation,
      :remember_token)
  end
end
