class Disclaimer < Prawn::Document
	def to_pdf
		move_down 20

		font 'Times-Roman'
		text 'Blue Trolley', size: 36
		render
	end

	def file_name
		'sample_ticket.pdf'
	end
end
