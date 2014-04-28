class ParticipantsController < ApplicationController
	before_action :set_participant, only: [:edit, :update, :destroy]

  def new
    @participant = Participant.new(user_account_id: params[:user_account_id], crew_id: params[:crew_id])
  end


  def create
    @participant = Participant.new(participant_params)
    if @participant.save
      flash[:success] = "#{@participant.display_name} has been successfully registered as Blue Trolley event participant."
      ParticipantsMailer.created(@participant).deliver
#      ParticipantsMailer.approval_requested(@participant).deliver
      redirect_to @participant.user_account
    else
      render :new
    end
  end


  def edit
  end


  def update
    if @participant.update(participant_params)
      flash[:success] = "#{@participant.display_name} profile has been successfully updated."
      redirect_to @participant.user_account
    else
      render :edit
    end
  end


  def destroy
    user_account = @participant.user_account
    @participant.destroy
    flash[:success] = "#{@participant.display_name} has been deleted from Blue Trolley participants list."
    redirect_to user_account
  end


  def index
    crew_id = params[:crew_id]
  	@participants = crew_id.nil? ? Participant.order(:last_name, :first_name) :
      Participant.where(crew_id: crew_id).order(:last_name, :first_name)
    @crew = Crew.find(crew_id) unless crew_id.nil?
  end


  def search
    pattern = params[:search][:pattern].strip
    @participants = Participant.order(:last_name, :first_name).select do |p|
      p.last_name =~ /#{pattern}/i || p.first_name =~ /#{pattern}/i
    end
  end


  def flagged
    @participants = Participant.order(:last_name, :first_name).select do |p|
      p.flagged
    end
  end


  def adults
    @participants = Participant.order(:last_name, :first_name).select do |p|
      p.category == :adult
    end
  end


  def adults_onsite
    @participants = Participant.order(:last_name, :first_name).select do |p|
      p.category == :adult && !p.registered_at.nil?
    end
  end


  def children
    @participants = Participant.order(:last_name, :first_name).select do |p|
      p.category == :child
    end
  end


  def children_onsite
    @participants = Participant.order(:last_name, :first_name).select do |p|
      p.category == :child && !p.registered_at.nil?
    end
  end


  def babies
    @participants = Participant.order(:last_name, :first_name).select do |p|
      p.category == :baby
    end
  end


  def babies_onsite
    @participants = Participant.order(:last_name, :first_name).select do |p|
      p.category == :baby && !p.registered_at.nil?
    end
  end


  def total_registered
    @participants = Participant.order(:last_name, :first_name)
  end


  def total_onsite
    @participants = Participant.order(:last_name, :first_name).select do |p|
      !p.registered_at.nil?
    end
  end


  def expected
    @participants = Participant.order(:last_name, :first_name).select do |p|
      p.registered_at.nil?
    end
  end


private
  def set_participant
    @participant = Participant.find(params[:id])
  end


  def participant_params
    params.require(:participant).permit(:user_account_id, :crew_id, :last_name, :first_name,
      :ticket_code, :email, :address_line_1, :age_category, :age, :cell_phone, :sent, :sent_by,
      :registered_at, :registered_by, :flagged, :notes)
  end
end
