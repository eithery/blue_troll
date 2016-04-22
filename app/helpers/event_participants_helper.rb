# Eithery Lab, 2016.
# EventParticipantsHelper.
# Represents a helper class for event participants related views.

module EventParticipantsHelper
  def remained_participants_for(event)
    current_user.participants.select do |person|
      !event.participants.any? { |event_participant| event_participant.person == person }
    end
  end


  def can_send_payment?(event_participant)
    event_participant.approved? && event_participant.unpaid? &&
      !current_user.can_confirm_payment_of?(event_participant)
  end


  def can_download_ticket?(event_participant)
    event_participant.payment_confirmed?
  end
end
