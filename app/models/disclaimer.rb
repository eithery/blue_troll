class Disclaimer < Prawn::Document
	def initialize
		super()
	end

	def to_pdf
		register_fonts
		self.line_width = 1
		transparent(0.5) { stroke_bounds }

		font 'calibri'

		bounding_box [30, cursor-10], width: 200 do
			image 'app/assets/images/bar_code.png', scale: 0.9
			move_down 2
			text "*123456789*", size: 10
		end
		bounding_box [300, cursor+80], width: 220 do
			text "Volchij Hvost", size: 20, :align => :right
			text "Волчий Хвост", size: 16, :align => :right
			text "Maria Romanova", size: 20, :align => :right
			text "A", size: 24, :align => :right
		end

		move_down 25
		fill_color '17365D'
		indent 30 do
			font 'Times-Roman', size: 36 do 
				text 'Blue Trolley'
			end
			stroke do
				stroke_color "1736A0"
				line_width 1
				horizontal_line 0, 475, at: cursor
			end
		end


		move_down 30
		fill_color '000000'
		font 'calibri-bold'
		text "Delaware Water Gap KOA, 233 Hollow Road, East Stroudsburg, PA 18301\nSeptember 27, 2013 - September 29, 2013.",
			size: 14, :align => :center

		move_down 12
		font 'arial', size: 12 do
			text "INFORMED CONSENT / LIABILITY RELEASE", :align => :center
		end

		move_down 12
		bounding_box([40, cursor], width: 450) do
			font_size 11
			text "\u2022 I understand and am fully aware of the fact that participation in the Event" +
				"involves potential risk of injury."
			move_down 4
			text "\u2022 I understand and acknowledge that all of the program activities in this Event are strictly voluntary. " +
				"I will participate in these activities to whatever degree I deem appropriate of my own free choice " +
				"and only after due consideration of my own health, physical abilities and medical condition."
			move_down 4
			text "\u2022 I agree that I am solely responsible for my own participation and emotional well-being."
			move_down 4
			text "\u2022 I agree that I am fully responsible for well-being of all persons, whom I am the legal guardian " +
				"for during the Event."
			move_down 4
			text "\u2022 I willingly and knowingly assume for myself and all persons whom I am responsible for, " +
				"all risk of physical injury and emotional upset, which may occur during or after participating " +
				"in any aspect of the Event."
			move_down 4
			text "\u2022 I agree to hold the Venue and the Event organizers harmless of any liability arising " +
				"out of my participation in the Event."
			move_down 4
			text "\u2022 Should the Venue, Event organizers or any party acting on their behalf be required to " +
				"incur attorney’s fees, or any other costs to enforce this agreement, I agree to indemnity and hold the Venue, " +
				"the Event organizers or any party acting on their behalf, harmless for all such fees and costs."
		end

		move_down 20
		bounding_box([40, cursor], width: 450) do
			text "On this day of ____________________, 2013, I, _________________________________________ ,\n" +
				"of my own free will, have read, understand and acknowledge the risks and liability for myself " +
				"and on behalf of all persons for who I am the legal guardian during the Event."
		end

		move_down 20
		stroke do
			stroke_color "000000"
			horizontal_line 40, 240, at: cursor
		end
		font_size 9
		move_down 2
		indent 40 do
			text 'Participant Signature'
		end

		move_down 20
		stroke do
			horizontal_line 40, 240, at: cursor
			horizontal_line 290, 490, at: cursor
		end

		move_down 2
		indent 40 do
			text "Parent/Guardian Signature" + (" " * 80) + "Printed Parent/Guardian Name"
		end

		move_down 5
		indent 40 do
			text '31 Gadsen Place, Apt 1F Staten Island, NY 10314', size: 12
		end

		stroke do
			horizontal_line 40, 490, at: cursor
		end
		move_down 2
		indent 40 do
			text 'Address   City   State   Zip'
		end

		render
	end


	def file_name
		'sample_ticket.pdf'
	end


private
	def register_fonts
		font_families.update('calibri' => {
			normal: "app/assets/fonts/calibri.ttf"
		})
		font_families.update('calibri-bold' => {
			normal: "app/assets/fonts/calibrib.ttf"
		})
		font_families.update('arial' => {
			normal: "app/assets/fonts/arial.ttf"
		})
	end
end
