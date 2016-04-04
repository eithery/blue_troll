# Eithery Lab, 2016.
# PasswordResetsController.
# Performs forget password and password reset operations.

class PasswordResetsController < ApplicationController
  layout 'blank'

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
  end
end
