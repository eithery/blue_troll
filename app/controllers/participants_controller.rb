class ParticipantsController < ApplicationController
	before_action :set_participant, only: [:show, :edit, :update, :destroy]

  def index
  	@participants = Participant.all
    crew_id = params[:crew_id]
    @crew = Crew.find(crew_id) unless crew_id.nil?
  end


  def show
  end


  def new
  	@participant = Participant.new
    @crews = Crew.all
    crew_id = params[:crew_id]
    @selected_crew = Crew.find(crew_id) unless crew_id.nil?
  end


  def edit
  end


  def create
#    corrected_params = participant_params.dup
#    crew = Crew.find_by_name(participant_params[:crew])
#    corrected_params[:crew] = crew
    @participant = Participant.new(crew_id: 2, last_name: 'Romanova', first_name: 'Maryika', ticket_code: '123')

    respond_to do |format|
      if @participant.save!
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
    params.require(:participant).permit(:last_name, :first_name, :crew)
  end
end
