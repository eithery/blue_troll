require 'sendgrid-ruby'

class ParticipantsMailer < ActionMailer::Base
  include MailersHelper
  include SendGrid


  def created(participant)
    set_members participant
    mail to: target, from: "Blue_Trolley <#{club_email}>",
      subject: "#{sender}: #{participant_created_subject}"
  end


  def approval_requested(participant)
    set_members participant
    mail to: participant.crew.emails, from: "Blue_Trolley <#{club_email}>",
      subject: "#{sender}: #{approval_request_subject}"
  end


  def approved(participant)
    set_members participant
    mail to: target, from: "Blue_Trolley <#{club_email}>",
      subject: "#{sender}: #{participant_approved_subject}"
  end


  def send_ticket_to(participant)
    @participant = participant
    mail to: target, from: "notifications@bluetrolley.club",
      subject: "#{sender}: download ticket link"

    # from = Email.new(email: 'notifications@bluetrolley.club')
    # to = Email.new(email: 'michael.protsenko@gmail.com')
    # subject = "Download ticket link"
    # content = Content.new(type: 'text/plain', value: 'Hello from SendGrid')
    # mail = Mail.new(from, subject, to, content)

    # sg = SendGrid::API.new(api_key: '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')
    # response = sg.client.mail._('send').post(request_body: mail.to_json)
    # puts response.status_code
    # puts response.body
    # puts response.headers
  end


private
  def set_members(participant)
    @participant = participant
    @crew = participant.crew
  end

  def target
    [@participant.user_account.email, @participant.email].uniq
  end
end
