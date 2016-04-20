# Eithery Lab, 2016.
# EventParticipantsController.
# Performs participants related operations belongs to the event.

class EventParticipantsController < ApplicationController
  before_action :retrieve_event, only: [:create, :destroy]

  def index
  end


  def create
    total_selected = 0
    crew = @event.crews.first
    params[:selected_participants].each do |id, value|
      if value.to_i == 1
        crew.participants.create!(participant_id: id.to_i, created_by: current_user.name, updated_by: current_user.name)
        total_selected += 1
      end
    end
    flash[:success] = "#{total_selected} #{'participant'.pluralize(total_selected)} registered to the event" if total_selected > 0
    redirect_to event_path(@event)
  end


  def destroy
    crew = @event.crews.first
    participant = EventParticipant.find(params[:id])
    crew.participants.destroy participant
    flash[:success] = "The participation of #{participant.name} at #{@event.name} has been canceled"
    redirect_to event_path(@event)
  end


private

  def retrieve_event
    @event = Event.find(params[:event_id])
  end
end
