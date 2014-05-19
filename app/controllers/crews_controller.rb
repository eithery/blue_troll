class CrewsController < ApplicationController
  before_filter :signed_in_user
  before_filter :privileged_user, only: [:show]

  def index
  	@crews = Crew.where(active: true).order(:name)
  end


  def show
  end


private
  def privileged_user
    @crew = Crew.find(params[:id])
    redirect_to root_path unless current_user.admin? || current_user.financier? || @crew.lead?(current_user)
  end
end
