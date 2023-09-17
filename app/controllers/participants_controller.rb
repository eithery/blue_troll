require 'csv'

class ParticipantsController < ApplicationController
  before_action :signed_in_user
	before_action :set_participant, only: [:edit, :update, :destroy, :approve]


  def new
    user_account_id = params[:user_account_id]
    crew_id = params[:crew_id]
    user_account = user_account_id.nil? ? UserAccount.new : UserAccount.find(user_account_id)
    @participant = Participant.new(user_account: user_account, requested_crew_id: crew_id)
  end


  def create
    @participant = Participant.new(participant_params)

    if @participant.user_account_id.blank?
      crew = Crew.find(participant_params[:requested_crew_id])
      email = participant_params[:email]
      unless email.blank?
        email = email.downcase
        user = UserAccount.find_by_email(email)
        if !user.nil? && user.crew != crew
          flash.now[:warning] = "You selected existing email which belongs to another crew."
          render :new
          return
        end
        if user.nil?
          pwd = SecureRandom.urlsafe_base64
          user = UserAccount.create!(login: email, email: email, email_confirmation: email,
            password: pwd, password_confirmation: pwd, crew: crew)
          UserAccountsMailer.registered(user).deliver
        end
        @participant.user_account = user
      else
        flash.now[:warning] = "Email address should be entered to add participant to the selected crew."
        render :new
        return
      end
    end

    if @participant.save
      flash[:success] = "#{@participant.display_name} has been successfully registered as Blue Trolley event participant."
      ParticipantsMailer.created(@participant).deliver
      ParticipantsMailer.approval_requested(@participant).deliver
      redirect_to @participant.requested_crew_id.blank? ? @participant.user_account : @participant.crew
    else
      render :new
    end
  end


  def edit
  end


  def update
    if @participant,paid?
      flash.now[:error] = "Cannot update personal info for paid participants."
      render: edit
      return
    end
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
    @crew = Crew.find(crew_id) unless crew_id.nil?
    @participants = @crew.participants
  end


  def approve
    @index = params[:index]
    @participant.update_attributes(approved_at: Time.now, approved_by: current_user.login)
    ParticipantsMailer.approved(@participant).deliver
    respond_to do |format|
      format.html { redirect_to crew_path(current_user.crew) }
      format.js
    end
  end


  def search
    pattern = params[:search][:pattern].strip
    return @participants = [] if pattern.blank?

    @participants = Participant.order(:last_name, :first_name).select do |p|
      p.last_name =~ /#{pattern}/i || p.first_name =~ /#{pattern}/i
    end
  end


  def flagged
    @participants = Participant.order(:last_name, :first_name).select do |p|
      p.flagged?
    end
  end


  def adults
    @participants = Participant.order(:last_name, :first_name).select do |p|
      p.age_category == AgeCategory::ADULT
    end
  end


  def adults_onsite
    @participants = Participant.order(:last_name, :first_name).select do |p|
      p.age_category == AgeCategory::ADULT && !p.registered_at.nil?
    end
  end


  def children
    @participants = Participant.order(:last_name, :first_name).select do |p|
      p.age_category == AgeCategory::CHILD
    end
  end


  def children_onsite
    @participants = Participant.order(:last_name, :first_name).select do |p|
      p.age_category == AgeCategory::CHILD && !p.registered_at.nil?
    end
  end


  def babies
    @participants = Participant.order(:last_name, :first_name).select do |p|
      p.age_category == AgeCategory::BABY
    end
  end


  def babies_onsite
    @participants = Participant.order(:last_name, :first_name).select do |p|
      p.age_category == AgeCategory::BABY && !p.registered_at.nil?
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


  def export_paid_by_crew
    crew = Crew.find(params[:crew_id])
    export_folder = 'data/export'
    Dir.mkdir(export_folder) unless Dir.exists?(export_folder)
    paid_participants_path = "#{export_folder}/#{crew.to_file_name}_paid.csv"

    CSV.open(paid_participants_path, 'w') do |csv|
      csv << ['Participant', 'Email', 'Status', 'Payment sent', 'Payment confirmed', 'Payment confirmed by']
      crew.participants.each do |p|
        csv << [p.full_name, p.email, 'paid', p.payment_sent_at, p.payment_confirmed_at, p.payment_confirmed_by] if p.paid?
      end
    end

    send_file paid_participants_path, type: 'application/csv', disposition: 'attachment'
  end


  def export_awaiting_participants
    export_folder = 'data/export'
    Dir.mkdir(export_folder) unless Dir.exists?(export_folder)
    awaiting_participants_path = "#{export_folder}/awaiting_participants.csv"

    CSV.open(awaiting_participants_path, 'w') do |csv|
      csv << ['Participant', 'Crew', 'Email', 'Status', 'Payment sent', 'Payment confirmed', 'Payment confirmed by']
      Participant.all.order(:last_name, :first_name).each do |p|
        csv << [p.full_name, p.crew.name, p.email, 'paid', p.payment_sent_at, p.payment_confirmed_at, p.payment_confirmed_by] if p.paid? && !p.checked_in?
      end
    end

    send_file awaiting_participants_path, type: 'application/csv', disposition: 'attachment'
  end


  def export_participants_with_email
    export_folder = 'data/export'
    Dir.mkdir(export_folder) unless Dir.exists?(export_folder)
    all_participants_with_email_path = "#{export_folder}/all_participants_with_email.csv"

    CSV.open(all_participants_with_email_path, 'w') do |csv|
      csv << ['Participant', 'Crew', 'User Account Email', 'Participant Email']
      Participant.all.order(:last_name, :first_name).each do |p|
        csv << [p.full_name, p.crew.name, p.user_account.email, p.email] unless p.email.nil?
      end
    end

    send_file all_participants_with_email_path, type: 'application/csv', disposition: 'attachment'
  end


private
  def set_participant
    @participant = Participant.find(params[:id])
  end


  def participant_params
    params.require(:participant).permit(:user_account_id, :requested_crew_id, :last_name, :first_name,
      :ticket_code, :email, :address_line_1, :age_category, :age, :cell_phone, :sent, :sent_by,
      :registered_at, :registered_by, :flagged, :notes)
  end
end
