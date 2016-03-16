# Eithery Lab, 2016.
# ApplicationMailer.
# Represents a base class for all mailers.

class ApplicationMailer < ActionMailer::Base
  CLUB_EMAIL = 'bluetrolley.app@gmail.com'

  default from: CLUB_EMAIL
  layout 'mailer'
end
