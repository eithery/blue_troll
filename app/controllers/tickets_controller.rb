class TicketsController < ApplicationController
	def download
		send_file('data/tickets/test_ticket.pdf', type: 'application/pdf', x_sendfile: true)
	end


	def create
		output = Disclaimer.new.to_pdf
		send_data output, filename: 'sample_ticket.pdf', type: 'application/pdf', disposition: 'inline'
	end
end
