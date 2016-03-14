# Eithery Lab, 2016.
# SessionsHelper.
# Represents a helper class for sessions related views.

module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
    self.current_user = user
  end


  def log_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end


  def current_user?(user)
    user == current_user
  end


  def current_user=(user)
    @current_user = user
  end


  def current_user
    @current_user #||= UserAccount.find_by(remember_token: cookies[:remember_token])
  end


  def logged_in?
    !current_user.nil?
  end
end
