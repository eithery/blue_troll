class CrewsController < ApplicationController
  before_filter :signed_in_user
  
  def index
  	@crews = Crew.order(:name)
  end


  def show
    @crew = Crew.find(params[:id])
  end
end
