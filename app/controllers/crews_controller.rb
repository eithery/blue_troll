class CrewsController < ApplicationController
  def index
  	@crews = Crew.order(:name)
  end


  def show
  end
end
