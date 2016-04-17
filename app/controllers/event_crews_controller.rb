# Eithery Lab, 2016.
# EventCrewsController.
# Performs crews related operations belongs to event.

class EventCrewsController < ApplicationController
  def index
    event = Event.find(params[:event_id])
    @event_crews = event.crews
  end


  def create
  end


  def update
  end


  def destroy
  end
end
