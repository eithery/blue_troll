# Eithery Lab, 2016.
# UserAccountsMailer.
# Represents a mailer to send activation, password reset and other notifications to users.

class UserAccountsMailer < ApplicationMailer

  def account_activation(user)
    mail_to user, 'Account activation'
  end


  def registered(user)
    mail_to user, registered_subject
  end


  def activated(user)
    mail_to user, activated_subject
  end


  def password_reset(user)
    mail_to user, password_reset_subject
  end


  def password_changed(user)
    mail_to user, password_changed_subject
  end


private

  def mail_to(user, subject)
    @user = user
    mail to: @user.email, from: "Blue_Trolley <#{CLUB_EMAIL}>", subject: "Blue Trolley: #{subject}"
  end
end
