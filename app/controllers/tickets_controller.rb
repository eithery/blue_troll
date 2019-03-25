require 'zip'

class TicketsController < ApplicationController
  before_action :signed_in_user, only: [:download_for_crew, :download_for_user, :send_link]
  before_action :correct_crew_lead, only: [:download_for_crew]


  def download_for_crew
    download_for @crew
  end


  def download_for_user
    user = UserAccount.find(params[:user_account_id])
    download_for user
  end


  def download
    participant = Participant.find_by_ticket_code(params[:ticket_code])
    respond_to_pdf create_ticket(participant) unless participant.nil?
  end


  def send_link
    participant = Participant.find(params[:participant_id])
    ParticipantsMailer.send_ticket_to(participant).deliver
    flash[:success] = "Email with download ticket link has been sent to #{participant.display_name}."
    redirect_to participant.crew
  end


private

  def respond_to_pdf(disclaimer)
    send_data disclaimer.to_pdf.render, filename: disclaimer.file_name, type: 'application/pdf',
      disposition: 'attachment'
  end


  def create_ticket(participant)
    Disclaimer.new(id: participant.ticket_code.to_i(16).to_s, group: participant.crew.name,
      group_native: participant.crew.native_name, name: "#{participant.first_name} #{participant.last_name}",
      address: participant.address, age: age_label(participant))
  end


  def age_label(participant)
    return "A" if participant.age_category == AgeCategory::ADULT
    return "C #{age_value(participant.age)}" if participant.age_category == AgeCategory::CHILD
    return "B #{age_value(participant.age)}" if participant.age_category == AgeCategory::BABY
  end


  def age_value(age)
    age.nil? || age == 0 ? '____' : age.to_s
  end


  def correct_crew_lead
    set_crew
    redirect_to root_path unless @crew.lead?(current_user) || current_user.admin?
  end


  def set_crew
    @crew = Crew.find(params[:crew_id])
  end


  def download_for(entity)
    file_name = entity.to_file_name
    base_folder = "data/tickets"
    zipfile_name = "#{file_name}_2019.zip"
    zipfile_path = "#{base_folder}/#{zipfile_name}"
    tickets_path = "#{base_folder}/#{file_name}"

    Dir.mkdir(tickets_path) unless Dir.exists?(tickets_path)

    entity.participants.each do |participant|
      if participant.payment_confirmed?
        ticket = create_ticket(participant)
        ticket.to_pdf.render_file("#{tickets_path}/#{ticket.file_name}")
      end
    end

    Zip::File.open(zipfile_path, Zip::File::CREATE) do |zipfile|
      Dir["#{tickets_path}/*.pdf"].each do |file|
        begin
          zipfile.add(File.basename(file), file)
          rescue
        end
      end
    end

    FileUtils.rm_r(tickets_path)
    send_file zipfile_path, filename: zipfile_name, type: 'application/zip', disposition: 'attachment'
  end
end
