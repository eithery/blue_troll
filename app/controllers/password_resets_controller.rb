# Eithery Lab, 2016.
# PasswordResetsController.
# Performs forget password and password reset operations.

class PasswordResetsController < ApplicationController
  layout 'blank'

  before_action :retrieve_user, only: [:edit, :update]
  before_action :assert_valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
  end


  def create
    @user = UserAccount.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = "Password reset link has been sent to #{@user.email}"
      redirect_to root_url
    else
        flash.now[:danger] = 'Entered email address not found'
        render :new
    end
  end


  def edit
  end


  def update
    if params[:user_account][:password].empty?
      @user.errors.add(:password, "can't be empty")
      render :edit
    elsif @user.update_attributes(user_account_params.merge({ email_confirmation: @user.email }))
      log_in @user
      flash[:success] = 'Password has been reset'
      redirect_to @user
    else
      render :edit
    end
  end


private

  def user_account_params
    params.require(:user_account).permit(:password, :password_confirmation)
  end


  def retrieve_user
    @user = UserAccount.find_by(email: params[:email])
  end


  def assert_valid_user
    unless @user && @user.activated? && @user.authenticated?(:reset, params[:id])
      redirect_to root_url
    end
  end


  def check_expiration
    if @user.password_reset_expired?
      flash[:danger] = 'Password reset link has expired'
      redirect_to new_password_reset_path
    end
  end
end
