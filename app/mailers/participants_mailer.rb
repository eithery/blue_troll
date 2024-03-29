class ParticipantsMailer < ActionMailer::Base
  include MailersHelper

  def created(participant)
    set_members participant
    mail to: target, from: "Blue Trolley <#{club_email}>",
      subject: "#{sender}: #{participant_created_subject}"
  end


  def approval_requested(participant)
    set_members participant
    mail to: participant.crew.emails, from: "Blue Trolley <#{club_email}>",
      subject: "#{sender}: #{approval_request_subject}"
  end


  def approved(participant)
    set_members participant
    mail to: target, from: "Blue Trolley <#{club_email}>",
      subject: "#{sender}: #{participant_approved_subject}"
  end


  def send_ticket_to(participant)
    @participant = participant
    mail to: target, from: "Blue Trolley <#{club_email}>",
      subject: "#{sender}: download ticket link"
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
