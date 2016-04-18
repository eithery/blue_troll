# Eithery Lab, 2016.
# EventCrewsHelper.
# Represents a helper class for event crews related views.

module EventCrewsHelper
  def remained_crews_for(event)
    crews = Crew.where(event_type: event.event_type)
    crews.select do |crew|
      !event.crews.any? { |event_crew| event_crew.prototype == crew }
    end
  end
end
