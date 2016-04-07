# Eithery Lab, 2016.
# CrewsController
# Performs operations with crews.

class CrewsController < ApplicationController
  include CrewsHelper

  before_action :retrieve_crew, only: [:edit, :update, :destroy]

#  before_filter :signed_in_user
#  before_filter :privileged_user, only: [:show]


  def index
  	@crews = all_crews
  end


  def show
  end


  def new
    @crew = Crew.new
  end


  def create
    @crew = Crew.new crew_params
    @crew.created_by = @crew.updated_by = current_user.login
    if @crew.save
      flash[:success] = "Crew '#{@crew.name}' has been created"
      redirect_to crews_path
    else
      flash.now[:danger] = 'New crew form contains invalid data'
      render :new
    end
  end


  def edit
    if @crew.update(crew_params)
      flash[:success] = "Crew '#{@crew.name}' has been updated"
      redirect_to crews_path
    else
      flash.now[:danger] = 'Edit crew form contains invalid data'
      render :edit
    end
  end


  def update
  end


  def destroy
    crew_name = @crew.name
    @crew.destroy
    flash[:success] = "Crew '#{crew_name}' has been deleted"
    redirect_to crews_path
  end

private

  def privileged_user
    @crew = Crew.find(params[:id])
    redirect_to root_path unless current_user.admin? || current_user.financier? || @crew.lead?(current_user)
  end


  def crew_params
    params.require(:crew).permit(:name, :native_name, :event_type_id, :active, :location, :notes)
  end


  def retrieve_crew
    @crew = Crew.find(params[:id])
  end
end
