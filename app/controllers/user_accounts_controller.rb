class UserAccountsController < ApplicationController
  def new
    @user_account = UserAccount.new
  end

  def show
    @user_account = UserAccount.find(params[:id])
  end

  def create
    @user_account = UserAccount.new(user_params)
    if @user_account.save
      flash[:success] = "Welcome to Blue Troll application!"
      redirect_to @user_account
    else
      render 'new'
    end
  end


private
  def user_account_params
    params.require(:user_account).permit(:email, :password, :password_confirmation, :remember_token)
  end
end
