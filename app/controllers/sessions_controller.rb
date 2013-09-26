class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(session_params[:email])
    if user && user.authenticate(session_params[:password])
      sign_in user
      redirect_to user
    else
      flash.now[:error] = "Invalid email/password combination."
      render 'new'
    end
  end

  def destroy
  end


private
  def session_params
    params.require(:session).permit(:email, :password)
  end
end
