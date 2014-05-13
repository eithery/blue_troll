class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper


private
  def set_user_account
    @user = UserAccount.find(params[:id])
  end


  def signed_in_user
    redirect_to signin_path unless signed_in?
  end


  def correct_user
    set_user_account
    redirect_to root_path unless current_user?(@user)
  end
end
