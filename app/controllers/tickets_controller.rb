require 'zip'

class TicketsController < ApplicationController
	def create
		define_native_group_name
		respond_to_pdf Disclaimer.new(params)
	end


	def generate_crew_tickets
		crew = Crew.find(params[:crew_id])

		base_folder = "data/tickets"
		zipfile_name = "#{crew.to_file_name}_fall_2013.zip"
		zipfile_path = "#{base_folder}/#{zipfile_name}"
		crew_ticket_path = "#{base_folder}/#{crew.to_file_name}"

		Dir.mkdir(crew_ticket_path) unless Dir.exists?(crew_ticket_path)

		crew.participants.each do |participant|
			if participant.payment_confirmed?
				ticket = create_ticket(participant)
				ticket.to_pdf.render_file("#{crew_ticket_path}/#{ticket.file_name}")
			end
		end

		Zip::File.open(zipfile_path, Zip::File::CREATE) do |zipfile|
   		Dir["#{crew_ticket_path}/*.pdf"].each do |file|
				begin
   				zipfile.add(File.basename(file), file)
    			rescue
    		end
    	end
		end

		FileUtils.rm_r(crew_ticket_path)
		send_file zipfile_path, filename: zipfile_name, type: 'application/zip', disposition: 'attachment'
	end


	def generate_participant_ticket
		participant = Participant.find(params[:participant_id])
		respond_to_pdf create_ticket(participant)
	end


private
	def respond_to_pdf(disclaimer)
		send_data disclaimer.to_pdf.render, filename: disclaimer.file_name, type: 'application/pdf', disposition: 'attachment'
	end


	def define_native_group_name
		group_name = params[:group]
		Crew.all.each do |crew|
			if crew.name == group_name
				params[:group_native] = crew.native_name
				return
			end
		end
	end


	def create_ticket(participant)
		Disclaimer.new(id: participant.ticket_code.to_i(16).to_s, group: participant.crew.name,
			group_native: participant.crew.native_name, name: "#{participant.first_name} #{participant.last_name}",
			address: participant.address, age: age_label(participant))
	end


private
	def age_label(participant)
		return 'A' if participant.age_category == AgeCategory::ADULT
		return 'C' if participant.age_category == AgeCategory::CHILD
		return "B #{participant.age.nil? ? ____ : participant.age}"
	end
end
