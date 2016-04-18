# Eithery Lab, 2016.
# EventParticipantsController.
# Performs participants related operations belongs to the event.

class EventParticipantsController < ApplicationController
  before_action :retrieve_event, only: [:create, :destroy]

  def index
  end


  def create
  end


  def update
  end


  def destroy
  end


private

  def retrieve_event
    @event = Event.find(params[:event_id])
  end
end
