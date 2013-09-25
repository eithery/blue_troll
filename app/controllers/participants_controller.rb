class ParticipantsController < ApplicationController
	before_action :set_participant, only: [:show, :edit, :update, :destroy]

  def index
    crew_id = params[:crew_id]
  	@participants = crew_id.nil? ? Participant.order(:last_name, :first_name) :
      Participant.where(crew_id: crew_id).order(:last_name, :first_name)
    @crew = Crew.find(crew_id) unless crew_id.nil?
  end


  def search
    pattern = params[:search][:pattern].strip
    @participants = Participant.order(:last_name, :first_name).select do |p|
      p.last_name =~ /#{pattern}/ || p.first_name =~ /#{pattern}/
    end
  end


  def show
  end


  def edit
  end


  def new
  	@participant = Participant.new(crew_id: params[:crew_id])
  end


  def create
    @participant = Participant.new(participant_params)
    if @participant.save
      flash[:success] = "Participant #{@participant.full_name} was successfully created."
      redirect_to participants_path(crew_id: @participant.crew_id)
    else
      render action: 'new'
    end
  end


  def update
    if @participant.update(participant_params)
      flash[:success] = "Participant #{@participant.full_name} was successfully updated."
      redirect_to participants_path(crew_id: @participant.crew_id)
    else
      render action: 'edit'
    end
  end


  def destroy
    crew_id = @participant.crew_id
    @participant.destroy
    respond_to do |format|
      format.html { redirect_to participants_path(crew_id: crew_id) }
      format.json { head :no_content }
    end
  end


 private
  def set_participant
    @participant = Participant.find(params[:id])
  end


  def participant_params
    params.require(:participant).permit(:last_name, :first_name, :crew, :crew_id, :ticket_code, :email, :address,
      :child, :import_id, :sent, :sent_by, :reservation_number, :registered_at, :registered_by, :flagged, :notes)
  end
end
