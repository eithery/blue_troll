class RegistrationNotifier < ActionMailer::Base
  default from: "Blue Trolley <bluetrolley2014@gmail.com>"


  def registered
    mail to: "michael.protsenko@gmail.com", subject: "New Blue Trolley account created"
  end
end
