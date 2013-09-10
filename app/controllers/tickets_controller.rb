class TicketsController < ApplicationController
	def download
		send_file('data/tickets/test_ticket.pdf', type: 'application/pdf', x_sendfile: true)
	end


	def create
		code = params[:id] || "0000000000"
		name = params[:name] || "Unknown Participant"
		group = params[:group] || "Unknown Group"
		group_native = group
		address = params[:address] || ""
		age_category = params[:age] || "A"

		respond_to_pdf Disclaimer.new(code, name, group, group_native, address, age_category)
	end


	def respond_to_pdf(disclaimer)
		send_data disclaimer.to_pdf, filename: disclaimer.file_name, type: 'application/pdf', disposition: 'inline'
	end
end
