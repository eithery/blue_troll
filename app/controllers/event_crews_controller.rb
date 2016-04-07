# Eithery Lab, 2016.
# EventCrewsController.
# Performs crews related operations belongs to event.

class EventCrewsController < ApplicationController
  def index
    @crews = Crew.all
  end


  def create
  end


  def update
  end


  def destroy
  end
end
