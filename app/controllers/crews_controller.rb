class CrewsController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user, only: [:show]

  def index
  	@crews = Crew.order(:name)
  end


  def show
  end


private
  def correct_user
    @crew = Crew.find(params[:id])
    redirect_to root_path unless current_user.admin? || @crew.lead?(current_user)
  end
end
