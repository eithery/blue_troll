class ParticipantsController < ApplicationController
	before_action :set_participant, only: [:show, :edit, :update, :destroy]

  def index
    crew_id = params[:crew_id]
  	@participants = crew_id.nil? ? Participant.order(:last_name, :first_name) :
      Participant.where(crew_id: crew_id).order(:last_name, :first_name)
    @crew = Crew.find(crew_id) unless crew_id.nil?
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

    respond_to do |format|
      if @participant.save
        format.html { redirect_to participants_path(crew_id: @participant.crew_id),
          notice: 'Participant was successfully created.' }
        format.json { render action: 'show', status: :created, location: @participant }
      else
        format.html { render action: 'new' }
        format.json { render json: @participant.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    respond_to do |format|
      if @participant.update(participant_params)
        format.html { redirect_to participants_path(crew_id: @participant.crew_id),
          notice: 'Participant was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @participant.errors, status: :unprocessable_entity }
      end
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
    params.require(:participant).permit(:last_name, :first_name, :crew, :crew_id, :ticket_code)
  end
end
