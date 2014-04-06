class RegistrationNotifier < ActionMailer::Base
  default from: "bluetrolley2014@gmail.com"


  def registered(user)
    @user = user
    mail to: user.email, subject: "Blue Trolley club account activation"
  end
end
