# Eithery Lab, 2016.
# EventCrewsController.
# Performs crews related operations belongs to the event.

class EventCrewsController < ApplicationController
  before_action :retrieve_event, only: [:index, :create, :destroy]

  def index
  end


  def create
    total_selected = 0
    params[:selected_crews].each do |id, value|
      if value.to_i == 1
        @event.crews.create!(crew_id: id.to_i, created_by: current_user.name, updated_by: current_user.name)
        total_selected += 1
      end
    end
    flash[:success] = "#{total_selected} #{'crew'.pluralize(total_selected)} selected to the event" if total_selected > 0
    redirect_to event_event_crews_path(@event)
  end


  def update
  end


  def destroy
    crew = EventCrew.find(params[:id])
    @event.crews.destroy crew
    flash[:success] = "The crew has been removed from the #{@event.name} event"
    redirect_to event_event_crews_path(@event)
  end


private

  def retrieve_event
    @event = Event.find(params[:event_id])
  end
end
