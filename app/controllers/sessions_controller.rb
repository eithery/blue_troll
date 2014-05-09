class SessionsController < ApplicationController
  def new
  end


  def create
    login = session_params[:login].downcase
    user = UserAccount.find_by_login(login) || UserAccount.find_by_email(login)
    return invalid_login_password unless user

    if(user.authenticate(session_params[:password]))
      sign_in user
      flash[:warning] = "User account is not activated." unless user.active?
      redirect_to user
    else
      invalid_login_password
    end
  end


  def destroy
    sign_out
    redirect_to root_path
  end


private
  def session_params
    params.require(:session).permit(:login, :password)
  end


  def invalid_login_password
    flash.now[:warning] = "Invalid login/password combination."
    render 'new'
  end
end
