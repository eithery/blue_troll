# Eithery Lab, 2016.
# UserAccountsController
# Performs operations with user accounts.

class UserAccountsController < ApplicationController
  include SessionsHelper

#  before_filter :signed_in_user, only: [:show, :update_crew]
#  before_filter :correct_user, only: [:show, :update_crew]

  def index
  end


  def show
    @user = UserAccount.find(params[:id])
  end


  def new
    @user = UserAccount.new
    render layout: 'blank'
  end


  def create
    @user = UserAccount.new(user_account_params)
    @user.created_by = @user.updated_by = current_user || @user.login
    if @user.save
      UserAccountsMailer.registered(@user).deliver_now
      flash[:success] = "New user account for #{@user.name} has been created."
      redirect_to request_to_activate_path(id: @user.id)
    else
      flash.now[:danger] = 'New account registration form contains invalid data'
      render :new, layout: 'blank'
    end
  end


  def update
  end


  def destroy
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
    params.require(:user_account).permit(:login, :email, :email_confirmation, :password, :password_confirmation)
  end


  def valid_activation(user)
    flash[:success] = "Congratulation, #{user.name}! Your account has been successfully activated."
    redirect_to login_path
  end
end
