class ParticipantsMailer < ActionMailer::Base
  def created(participant, crew)
    @participant = participant
    @crew = crew
    target = [participant.user_account.email]
    target << participant.email unless participant.email == participant.user_account.email
    mail to: target, from: "Blue_Trolley <#{club_email}>",
      subject: "#{sender}: #{participant_created_subject}"
  end


  def approval_requested(participant, crew)
    @participant = participant
    @crew = crew
    mail to: participant.crew.emails, from: "Blue_Trolley <#{club_email}>",
      subject: "#{sender}: #{approval_request_subject}"
  end


  def approved(participant, crew)
    @participant = participant
    @crew = crew
    target = [participant.user_account.email]
    target << participant.email unless participant.email == participant.user_account.email
    mail to: target, from: "Blue_Trolley <#{club_email}>",
      subject: "#{sender}: #{participant_approved_subject}"
  end
end
