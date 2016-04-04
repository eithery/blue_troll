class PasswordResetController < ApplicationController
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
