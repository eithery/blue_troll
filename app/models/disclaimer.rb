require 'barby'
require 'barby/barcode/code_39'
require 'barby/outputter/prawn_outputter'

class Disclaimer < Prawn::Document

	# Creates the new disclaimer.
	def initialize(attributes)
		super()
		@unknown = "Unknown Participant"
		@code = attributes[:id] || "0000000000"
		@participant_name = attributes[:name] || @unknown
		@group_name = attributes[:group] || "Unknown Group"
		@group_native_name = attributes[:group_native] || @group_name
		@address = attributes[:address] || ""
		@age_category = attributes[:age] || "A"
	end


	# Generates the disclaimer content in PDF format.
	def to_pdf
		register_fonts
		self.line_width = 1
		transparent(0.5) { stroke_bounds }
		font 'calibri'

		move_down 80
		bounding_box [30, cursor+20], width: 400 do
			bar_code = Barby::Code39.new(@code)
			bar_code.annotate_pdf(self, x: 0, y: cursor)
			move_down 2
			text "*#{@code}*", size: 10
		end
		bounding_box [300, cursor+60], width: 220 do
			text @group_name, size: 20, :align => :right
			text @group_native_name, size: 16, :align => :right
			text @participant_name, size: 20, :align => :right
			text @age_category, size: 24, :align => :right
		end

		move_down 5
		fill_color '17365D'
		indent 30 do
			text 'Blue Trolley', size: 40
			stroke do
				stroke_color "1736A0"
				line_width 1
				horizontal_line 0, 475, at: cursor
			end
		end


		move_down 20
		fill_color '000000'
		font 'calibri-bold'
		text "Delaware Water Gap KOA, 233 Hollow Road, East Stroudsburg, PA 18301\nFriday, June 3, 2016 - Sunday, June 5, 2016.",
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

		move_down 10
		bounding_box([40, cursor], width: 460) do
			text "On this day of ____________________, 2016, I, ___________________________________________ ,\n" +
				"of my own free will, have read, understand and acknowledge the risks and liability for myself " +
				"and on behalf of all persons for who I am the legal guardian during the Event."
		end

		move_down 30
		stroke do
			stroke_color "000000"
			horizontal_line 40, 240, at: cursor
		end
		font_size 9
		move_down 3
		indent 40 do
			text 'Participant Signature'
		end

		move_down 30
		stroke do
			horizontal_line 40, 240, at: cursor
			horizontal_line 290, 490, at: cursor
		end

		move_down 3
		indent 40 do
			text "Parent/Guardian Signature" + spaces(75) + "Printed Parent/Guardian Name"
		end

		move_down @address.blank? ? 30 : 15
		indent 40 do
			text @address, size: 12
		end

		stroke do
			horizontal_line 40, 490, at: cursor
		end
		move_down 3
		indent 40 do
			text "Address" + spaces(80) + "City" + spaces(30) + "State" + spaces(30) + "Zip"
		end

		return self
	end


	def file_name
		return "unknown_participant.pdf" if @participant_name == @unknown
		first_name, last_name = @participant_name.split
		first_name = first_name.delete('/')
		"#{last_name}_#{first_name}_2016.pdf".downcase
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


	def spaces(number)
		" " * number
	end
end
