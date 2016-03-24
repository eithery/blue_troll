# Eithery Lab, 2016.
# SessionsHelper.
# Represents a helper class for sessions related views.

module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end


  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end


  def log_out
    forget current_user
    session.delete :user_id
    @current_user = nil
  end


  def forget(user)
    user.forget unless user.nil?
    cookies.delete :user_id
    cookies.delete :remember_token
  end


  def current_user?(user)
    user == current_user
  end


  def current_user
    if user_id = session[:user_id]
      @current_user ||= UserAccount.find_by(id: user_id)
    elsif user_id = cookies.signed[:user_id]
      user = UserAccount.find_by(id: user_id)
      if user && user.authenticated?(:remember, cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end


  def logged_in?
    !current_user.nil?
  end


  def has_validation_errors?
    !flash[:danger].blank? || !flash[:warning].blank?
  end


  def flash_error_message
    flash[:danger] || flash[:warning]
  end


  def animated_form_class
    has_validation_errors? ? '' : 'animated fadeInDown'
  end
end
