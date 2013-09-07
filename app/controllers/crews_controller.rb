class CrewsController < ApplicationController
  def index
  	@crews = Crew.all
  end


  def show
  end
end
