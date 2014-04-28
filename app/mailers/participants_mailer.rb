class ParticipantsMailer < ActionMailer::Base
  def created(participant, crew)
    @participant = participant
    @crew = crew
    mail to: participant.email, from: "Blue_Trolley <#{club_email}>",
      subject: "#{sender}: #{participant_created_subject}"
  end


  def approval_requested(participant, crew)
    @participant = participant
    @crew = crew
    mail to: participant.crew.emails, from: "Blue_Trolley <#{club_email}>",
      subject: "#{sender}: #{participant_created_subject}"
  end


  def approved(participant)
  end
end
