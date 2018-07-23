# Eithery Lab., 2016.
# Class CrewsController
# Crews controller.
# Performs operations with crews.

class CrewsController < ApplicationController
  include CrewsHelper

  before_action :signed_in_user
  before_action :privileged_user, only: [:show]


  def index
  	@crews = all_crews
  end


  def show
  end

private

  def privileged_user
    @crew = Crew.find(params[:id])
    redirect_to root_path unless current_user.admin? || current_user.financier? || @crew.lead?(current_user)
  end
end
