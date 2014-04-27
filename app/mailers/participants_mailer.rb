class ParticipantsMailer < ActionMailer::Base
  def created(participant)
    @participant = participant
    mail to: participant.crew.emails, from: "Blue_Trolley <#{club_email}>",
      subject: "#{sender}: #{participant_created_subject}"
  end


  def approved(participant)
  end
end
