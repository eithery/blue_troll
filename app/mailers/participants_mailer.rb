class ParticipantsMailer < ActionMailer::Base
  def created(participant, crew)
    set_members participant, crew
    mail to: target, from: "Blue_Trolley <#{club_email}>",
      subject: "#{sender}: #{participant_created_subject}"
  end


  def approval_requested(participant, crew)
    set_members participant, crew
    mail to: participant.crew.emails, from: "Blue_Trolley <#{club_email}>",
      subject: "#{sender}: #{approval_request_subject}"
  end


  def approved(participant, crew)
    set_members participant, crew
    mail to: target, from: "Blue_Trolley <#{club_email}>",
      subject: "#{sender}: #{participant_approved_subject}"
  end

private
  def set_members(participant, crew)
    @participant = participant
    @crew = crew
  end

  def target
    target = [@participant.user_account.email]
    target << @participant.email unless @participant.email == @participant.user_account.email
  end
end
