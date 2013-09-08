class TicketsController < ApplicationController
	def download
		send_file('data/tickets/test_ticket.pdf', type: 'application/pdf', x_sendfile: true)
	end


	def create
		respond_to_pdf Disclaimer.new
	end


	def respond_to_pdf(disclaimer)
		send_data disclaimer.to_pdf, filename: disclaimer.file_name, type: 'application/pdf', disposition: 'inline'
	end
end
