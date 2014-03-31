class RegistrationNotifier < ActionMailer::Base
  default from: "bluetrolley2014@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.registration_notifier.registered.subject
  #
  def registered
    @greeting = "Hi from Blue Trolley!"

    mail to: "michael.protsenko@mandosys.com"
  end
end
