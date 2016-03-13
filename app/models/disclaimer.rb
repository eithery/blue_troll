# Eithery Lab, 2016.
# Disclaimer model.
# Represents a legal disclaimer at the event.

require 'barby'
require 'barby/barcode/code_39'
require 'barby/outputter/prawn_outputter'

class Disclaimer < Prawn::Document
  attr_reader :participant

  def initialize(participant)
    super()
    @participant = participant
  end


  def to_pdf
    configure_fonts
    bar_code_section
    participant_info_section
    event_title_section
    event_info_section
    liability_section
    signature_section
    address_section
    self
  end


  def file_name
    first_name = participant.person.first_name
    last_name = participant.person.last_name
    "#{last_name}_#{first_name}_#{event_year}.pdf".downcase
  end


  def ticket_code
    participant.ticket_code || '0000000000'
  end


  def crew_name
    participant.crew.name
  end


  def crew_native_name
    participant.crew.native_name
  end


  def age_category
    age = participant.person.age
    age_label = age.nil? || age == 0 ? '____' : age.to_s

    return "A" if participant.person.adult?
    return "C #{age_label}" if participant.person.child?
    return "B #{age_label}" if participant.person.baby?
  end


  def event_title
    participant.event.name
  end


  def event_address
    participant.event.address&.gsub(/\s+/, ' ')&.strip || ''
  end


  def event_dates
    started_on = participant.event.started_on.to_date
    finished_on = participant.event.finished_on.to_date
    start_label = started_on.strftime "%A, %B %d"
    end_label = finished_on.strftime "%A, %B %d"
    started_on != finished_on ? "#{start_label} - #{end_label}" : start_label
  end


  def event_year
    participant.event.started_on.strftime "%Y"
  end


  def participant_address
    participant.person.address&.gsub(/\s+/, ' ')&.strip || ''
  end


private

  def register_fonts
    font_families.update('calibri' => { normal: "app/assets/fonts/calibri.ttf" })
    font_families.update('calibri-bold' => { normal: "app/assets/fonts/calibrib.ttf" })
    font_families.update('arial' => { normal: "app/assets/fonts/arial.ttf" })
  end


  def configure_fonts
    register_fonts
    self.line_width = 1
    transparent(0.5) { stroke_bounds }
    font 'calibri'
  end


  def spaces(number)
    " " * number
  end


  def bar_code_section
    move_down 80
    bounding_box [30, cursor+20], width: 400 do
      bar_code = Barby::Code39.new ticket_code
      bar_code.annotate_pdf(self, x: 0, y: cursor)
      move_down 2
      text "*#{ticket_code}*", size: 10
    end
  end


  def participant_info_section
    bounding_box [300, cursor+60], width: 220 do
      text crew_name, size: 20, :align => :right
      text crew_native_name, size: 16, :align => :right
      text participant.name, size: 20, :align => :right
      text age_category, size: 24, :align => :right
    end
  end


  def event_title_section
    move_down 5
    fill_color '17365D'
    indent 30 do
      text event_title, size: 40
      stroke do
        stroke_color "1736A0"
        line_width 1
        horizontal_line 0, 475, at: cursor
      end
    end
  end


  def event_info_section
    move_down 20
    fill_color '000000'
    font 'calibri-bold'
    text "#{event_address}\n#{event_dates}",
      size: 14, :align => :center
  end


  def liability_section
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
  end


  def signature_section
    move_down 10
    bounding_box([40, cursor], width: 460) do
      text "On this day of ____________________, #{event_year}, I, ___________________________________________ ,\n" +
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
  end


  def address_section
    move_down participant_address.blank? ? 30 : 15
    indent 40 do
      text participant_address.to_s, size: 12
    end
    stroke do
      horizontal_line 40, 490, at: cursor
    end
    move_down 3
    indent 40 do
      text "Address" + spaces(80) + "City" + spaces(30) + "State" + spaces(30) + "Zip"
    end
  end
end
