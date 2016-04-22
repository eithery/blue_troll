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


  def send_payment_available_at?(event)
    current_user.event_participants_at(event).any? { |p| can_send_payment?(p) }
  end


  def can_download_ticket?(event_participant)
    event_participant.payment_confirmed?
  end


  def tickets_available_at?(event)
    current_user.event_participants_at(event).any? { |p| can_download_ticket?(p) }
  end
end
