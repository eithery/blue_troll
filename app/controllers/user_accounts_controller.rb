class UserAccountsController < ApplicationController
  def new
    @user = UserAccount.new
  end


  def show
    @user = UserAccount.find(params[:id])
  end


  def create
    @user = UserAccount.new(user_account_params)
    if @user.save
      flash[:success] = "New user account for #{@user.name} has been created."
      RegistrationNotifier.registered(@user).deliver
      redirect_to request_to_activate_path(account_id: @user.id)
    else
      render 'new'
    end
  end


  def request_to_activate
    @user = UserAccount.find(params[:account_id])
  end


  def activate
    user_id = params[:activation][:user_account]
    activation_code = params[:activation][:code].strip
    user = UserAccount.find(user_id)
    if user.activate(activation_code)
      flash[:success] = "Congratulation! Your account has been successfully activated"
      redirect_to signin_path
    else
      flash[:warning] = "Incorrect activation code"
      redirect_to request_to_activate_path(account_id: user.id)
    end
  end


private
  def user_account_params
    params.require(:user_account).permit(:id, :login, :email, :email_confirmation, :password, :password_confirmation,
      :remember_token)
  end
end
