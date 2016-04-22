# Eithery Lab, 2016.
# ApplicationMailer.
# Represents a base class for all mailers.

class ApplicationMailer < ActionMailer::Base
  APP_EMAIL = 'bluetrolley.app@gmail.com'
  NO_REPLY_EMAIL = 'no-reply@bluetrolley.com'

  default from: "Blue Trolley <#{NO_REPLY_EMAIL}>", bcc: APP_EMAIL
  layout 'mailer'


  def mail_to(recipient, subject)
    mail to: recipient, subject: "Blue Trolley: #{subject} <No Reply>"
  end
end
