class UserAccountsMailer < ActionMailer::Base
  default from: "bluetrolley2014@gmail.com"

  def registered(user)
    @user = user
    mail to: user.email, subject: "Blue Trolley club account activation"
  end


  def activated(user)
  end


  def password_reset(user)
  end


  def password_changed(user)
  end
end
