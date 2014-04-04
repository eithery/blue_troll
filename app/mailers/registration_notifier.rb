class RegistrationNotifier < ActionMailer::Base
  default from: "bluetrolley2014@gmail.com"


  def registered(user_account)
    mail to: user_account.email, subject: "Blue Trolley club account activation"
  end
end
