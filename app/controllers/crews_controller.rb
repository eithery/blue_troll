class CrewsController < ApplicationController
  def index
  	@crews = Crew.order(:name)
  end


  def show
    @crew = Crew.find(params[:id])
  end
end
