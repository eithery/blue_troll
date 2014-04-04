module SessionsHelper
  def sign_in(user_account)
    cookies.permanent[:remember_token] = user_account.remember_token
    self.current_user = user_account
  end


  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end


  def current_user=(user_account)
    @current_user = user_account
  end


  def current_user
    @current_user ||= UserAccount.find_by_remember_token(cookies[:remember_token])
  end


  def signed_in?
    !current_user.nil?
  end
end
