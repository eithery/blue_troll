class TicketsController < ApplicationController
	def download
		send_file('data/tickets/test_ticket.pdf', type: 'application/pdf', x_sendfile: true)
	end
end
