# Eithery Lab., 2016.
# Class UserAccountsController
# UserAccounts controller.
# Performs operations with user accounts.

class UserAccountsController < ApplicationController

  before_action :signed_in_user, only: [:show, :update_crew]
  before_action :correct_user, only: [:show, :update_crew]
  before_action :set_user_account, only: [:request_to_activate, :change_password, :update_password]


  def new
    @user = UserAccount.new
  end


  def create
    @user = UserAccount.new(user_account_params)
    if @user.save
      UserAccountsMailer.registered(@user).deliver_now
      flash[:success] = "New user account for #{@user.name} has been created."
      redirect_to request_to_activate_path(id: @user.id)
    else
      render :new
    end
  end


  def show
  end


  def request_to_activate
  end


  def activate
    user_id = params[:activation][:user_account]
    activation_code = params[:activation][:code].strip
    user = UserAccount.find(user_id)
    return valid_activation user if user.activate(activation_code)

    flash[:danger] = "Invalid activation code."
    redirect_to request_to_activate_path(id: user.id)
  end


  def activate_by_link
    activation_token = params[:activation_token]
    user = UserAccount.find_by_activation_token(activation_token)
    return valid_activation user if user && user.activate(activation_token)

    flash[:danger] = "Invalid or expired activation link."
    redirect_to root_path
  end


  def change_password
  end


  def update_password
    @user.email_confirmation = @user.email
    @user.password = user_account_params[:password]
    @user.password_confirmation = user_account_params[:password_confirmation]
    if @user.save
      UserAccountsMailer.password_changed(@user).deliver
      flash[:success] = "Password has been changed successfully."
      redirect_to signin_path
    else
      render :change_password
    end
  end


  def update_crew
    crew_id = params[:user][:crew_id]
    crew = crew_id.blank? ? nil : Crew.find(crew_id)
    respond_to do |format|
      @user.update_attribute(:crew, crew)
      sign_in @user
      format.html { redirect_to @user }
      format.js
    end
  end

private

  def user_account_params
    params.require(:user_account).permit(:id, :login, :email, :email_confirmation, :password, :password_confirmation,
      :remember_token, :activation_token)
  end


  def valid_activation(user)
    flash[:success] = "Congratulation, #{user.name}! Your account has been successfully activated."
    redirect_to signin_path
  end
end
