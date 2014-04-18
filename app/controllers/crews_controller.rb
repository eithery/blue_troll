class CrewsController < ApplicationController
  def index
  	@crews = Crew.order(:name)
  end
end
