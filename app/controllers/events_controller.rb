# Eithery Lab, 2016.
# EventsController
# Performs operations with private club events.

class EventsController < ApplicationController
  def index
    @events = Event.order :started_on
  end


  def show
  end


  def new
    @event = Event.new
  end


  def create
  end


  def edit
  end


  def update
  end


  def destroy
  end
end
