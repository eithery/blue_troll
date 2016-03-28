# Eithery Lab, 2016.
# SessionsController.
# Performs session related operations.

class SessionsController < ApplicationController
  include SessionsHelper

  layout 'blank'

  def new
  end


  def create
    login = session_params[:login].downcase
    user = UserAccount.find_by(login: login) || UserAccount.find_by(email: login)

    if(user && user.authenticate(session_params[:password]))
      log_in user
      session_params[:remember_me] == '1' ? remember(user) : forget(user)
      flash[:warning] = 'User account is not activated' unless user.activated?
      redirect_to user
    else
      flash.now[:danger] = "Your user login or password is incorrect. Please try again"
      render :new
    end
  end


  def destroy
    log_out if logged_in?
    redirect_to root_url
  end


private

  def session_params
    params.require(:session).permit(:login, :password, :remember_me)
  end
end
