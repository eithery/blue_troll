class TicketsController < ApplicationController
	def download
		send_file('data/tickets/test_ticket.pdf', type: 'application/pdf', x_sendfile: true)
	end


	class TestDocument < Prawn::Document
		def to_pdf
			text 'Maryika, tell me about the book you reading!'
			render
		end
	end


	def create
		output = TestDocument.new.to_pdf
		respond_to do |format|
			format.pdf { send_data output, filename: 'sample.pdf', type: 'application/pdf', disposition: 'inline'}
			format.html { render text: "<h1>Use .pdf</h1>".html_safe }
		end
	end
end
