class SessionsController < ApplicationController
  def new
  end


  def create
    login = session_params[:login]
    user_account = UserAccount.find_by_login(login) || UserAccount.find_by_email(login)
    if user_account && user_account.authenticate(session_params[:password])
      sign_in user_account
      redirect_to user_account
    else
      flash.now[:warning] = "Invalid login/password combination."
      render 'new'
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
end
