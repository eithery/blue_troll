class PasswordResetController < ApplicationController
  def collect_info
  end


  def send_link
    email = params[:reset_password][:email].downcase
    @user = UserAccount.find_by_email(email) || UserAccount.find_by_login(email)
    if(@user)
      @user.generate_reset_token
      UserAccountsMailer.password_reset(@user).deliver
      flash[:success] = "Password reset link has been sent to #{@user.email}"
      redirect_to signin_path
    else
      flash.now[:warning] = "Entered user login or email is not found."
      render :collect_info
    end
  end


  def reset
    reset_token = params[:reset_token]
    @user = UserAccount.find_by_reset_password_token(reset_token)
    if @user
      @user.reset
      flash[:success] = "Password has been reset. Please change the password."
      redirect_to change_password_path(id: @user.id)
    else
      flash[:warning] = "Invalid reset password link."
      redirect_to signin_path
    end
  end
end
