# Eithery Lab, 2016.
# EventsController
# Performs operations with private club events.

class EventsController < ApplicationController
  before_action :retrieve_event, only: [:edit, :update, :destroy]

  def index
    @events = Event.order :started_on
  end


  def show
  end


  def new
    @event = Event.new
  end


  def create
    @event = Event.new event_params
    @event.created_by = @event.updated_by = current_user.login
    if @event.save
      flash[:success] = "Event '#{@event.name}' has been created"
      redirect_to events_path
    else
      flash.now[:danger] = 'New event form contains invalid data'
      render :new
    end
  end


  def edit
  end


  def update
    if @event.update(event_params)
      flash[:success] = "Event '#{@event.name}' has been updated"
      redirect_to events_path
    else
      flash.now[:danger] = 'Edit event form contains invalid data'
      render :edit
    end
  end


  def destroy
    event_name = @event.name
    @event.destroy
    flash[:success] = "Event '#{event_name}' has been deleted"
    redirect_to events_path
  end


private

  def retrieve_event
    @event = Event.find(params[:id])
  end


  def event_params
    params.require(:event).permit(:name, :short_name, :event_type_id, :started_on, :finished_on, :address, :notes)
  end
end
