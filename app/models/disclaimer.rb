class Disclaimer < Prawn::Document
	def to_pdf
		text 'Gwen, Kozya!'
		render
	end
end
