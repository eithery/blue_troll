class ParticipantsController < ApplicationController
	before_action :set_participant, only: [:show, :edit, :update, :destroy]

  def index
  	@participants = Participant.all
    @crew = Crew.find(params[:crew_id])
  end


  def show
  end


  def new
  	@participant = Participant.new
  end


  def edit
  end


  def create
    @participant = Participant.new(participant_params)

    respond_to do |format|
      if @participant.save
        format.html { redirect_to participants_url, notice: 'Participant was successfully created.' }
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
        format.html { redirect_to participants_url, notice: 'Participant was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @participant.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @participant.destroy
    respond_to do |format|
      format.html { redirect_to participants_url }
      format.json { head :no_content }
    end
  end


 private
  def set_participant
    @participant = Participant.find(params[:id])
  end


  def participant_params
    params.require(:participant).permit(:last_name, :first_name)
  end
end
