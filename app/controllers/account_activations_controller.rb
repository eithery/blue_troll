# Eithery Lab, 2016.
# AccountActivationsController.
# Performs account activation.

class AccountActivationsController < ApplicationController
  def new
    current_user.send_activation_email(with_new_link: true)
    flash[:success] = "The account activation link is sent to #{current_user.email}"
    redirect_to current_user
  end


  def edit
    user = UserAccount.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      flash[:success] = 'Congratulations! You account is activated'
      redirect_to user
    else
      flash[:danger] = 'Invalid activation link'
      redirect_to root_url
    end
  end
end
