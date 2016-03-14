# Eithery Lab, 2016.
# SessionsController.
# Performs session related operations.

class SessionsController < ApplicationController
  def new
  end


  def create
    login = session_params[:login].downcase
    user = UserAccount.find_by(login: login) || UserAccount.find_by(email: login)

    if(user && user.authenticate(session_params[:password]))
      log_in user
      flash[:warning] = "User account is not activated." unless user.active?
      redirect_to user
    else
      flash.now[:danger] = "Invalid login/password combination."
      render :new
    end
  end


  def destroy
    log_out
    redirect_to root_path
  end


private

  def session_params
    params.require(:session).permit(:login, :password)
  end
end
