# Eithery Lab, 2016.
# EventParticipantsHelper.
# Represents a helper class for event participants related views.

module EventParticipantsHelper
  def remained_participants_for(event)
    current_user.participants.select do |person|
      !event.participants.any? { |event_participant| event_participant.person == person }
    end
  end
end
