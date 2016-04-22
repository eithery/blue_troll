# Eithery Lab, 2016.
# UserAccountsMailer.
# Represents a mailer to send activation, password reset and other notifications to users.

class UserAccountsMailer < ApplicationMailer
  def account_activation(user)
    @user = user
    mail_to user.email, 'Account activation'
  end


  def password_reset(user)
    @user = user
    mail_to user.email, 'Password reset'
  end


  def registered(user)
    @user = user
    mail_to user.email, registered_subject
  end


  def activated(user)
    @user = user
    mail_to user.email, activated_subject
  end


  def password_changed(user)
    mail_to user.email, password_changed_subject
  end
end
