require 'barby'
require 'barby/barcode/code_39'
require 'barby/outputter/prawn_outputter'

class Disclaimer < Prawn::Document
  # Creates the new disclaimer.
  def initialize(attributes)
    super()
    @unknown = 'Unknown Participant'
    @code = attributes[:id] || '0000000000'
    @participant_name = attributes[:name] || @unknown
    @group_name = attributes[:group] || 'Unknown Group'
    @group_native_name = attributes[:group_native] || @group_name
    @address = attributes[:address] || ''
    @age_category = attributes[:age] || 'A'
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
      text @group_name, size: 18, align: :right
      text @group_native_name, size: 14, align: :right
      text @participant_name, size: 16, align: :right
      text @age_category, size: 18, align: :right
    end

    move_down 0
    fill_color '17365D'
    indent 30 do
      text 'Blue Trolley Inc.', size: 20
      stroke do
        stroke_color '1736A0'
        line_width 1
        horizontal_line 0, 475, at: cursor
      end
    end


    move_down 10
    fill_color '000000'
    font 'calibri'
    text 'Friday, September 20, 2024 - Sunday, September 22, 2024.', size: 12, align: :center

    move_down 8
    font 'arial', size: 10 do
      text 'INFORMED CONSENT / LIABILITY RELEASE', align: :center
    end

    move_down 8
    bounding_box([25, cursor], width: 500) do
      font_size 9
      text 'I hereby make this waiver, disclaimer, release of liability, and indemnification agreement ' \
        '(“Waiver and Release”), of my own volition in connection with the Event organized by Blue Trolley Inc. ' \
        '(“Blue Trolley”).'
      move_down 2
      text "\u2022 I acknowledge that I have been fully and adequately advised by Blue Trolley of the risks and implications " \
        'of using the Venue and participating in the Event, including inherent risks associated with waterborne activities. ' \
        'I will not use the Venue and/or participate in the Event while intoxicated by alcohol, medications and/or illegal drugs.'
      move_down 2
      text "\u2022 COVID-19 Warning. We have taken enhanced health and safety measures. " \
        'However, an inherent risk of exposure to COVID-19 and other communicable diseases exists ' \
        'in any public place where people are present.'
      move_down 2
      text "\u2022 I understand that participation in the Event involves potential risk of injury. " \
        'Event Organizers are not responsible for accidents, negligent or intentional acts of third parties, personal injury, ' \
        'serious injury and/or death, or damage to, destruction and/or loss of property. ' \
        '“Event Organizers” shall mean Blue Trolley, all of its subsidiaries and/or affiliates, ' \
        'and all of their directors, officers, employees, agents, and legal representatives. ' \
        'I intentionally, knowingly and willfully accept all known and unknown risks associated with the Event ' \
        'and my participating in the Event.'
      move_down 2
      text "\u2022 I understand and acknowledge that all of the program activities in this Event are strictly voluntary. " \
        'I will participate in these activities to whatever degree I deem appropriate and only after due consideration of my own ' \
        'health, physical abilities and medical condition.'
      move_down 2
      text "\u2022 I agree that I am voluntarily participating in the Event and I am fully responsible for my physical " \
        'and emotional well-being. I also agree that I am fully responsible for well-being of all persons of whom I am the legal ' \
        'guardian during the Event, including without limitation minor children, special needs individuals, or disabled ' \
        'individuals, and I acknowledge that I am responsible for their continuous supervision during the Event.'
      move_down 2
      text "\u2022 I willingly and knowingly assume for myself and all persons for whom I am responsible, all risk of " \
        'physical injury, death and emotional distress, which may occur during or after participating in any aspect of the Event.'
      move_down 2
      text "\u2022 I agree to indemnify, defend, and hold harmless the Event Organizers and Venue from any and all claims, " \
        'demands, actions, expenses, attorney’s fees, and liability whatsoever, whether suspected or unsuspected, vested or ' \
        'contingent, in law or in equity, existing by statute, common law, contract, or otherwise which have existed, do exist ' \
        'or may exist, in any way relating to any and all losses, injuries and damages of any and every kind, to person or ' \
        'property, arising out of my participation in the Event and/or the participation of individuals of whom I am the legal guardian.'
      move_down 2
      text "\u2022 If the Event Organizers or any party acting on their behalf be required to incur attorney’s fees, or any other " \
        'costs, to enforce this Waiver and Release, I agree to indemnity and hold them harmless for all such fees and costs.'
      move_down 2
      text "\u2022 For and in consideration of the services provided in connection with the Event, the Event Organizers and " \
        'Venue shall not be held responsible and/or liable, and are hereby released from responsibility and/or liability for any ' \
        'loss, loss of property, damage, injury, accident and/or death associated with the Event.'
      move_down 2
      text "\u2022 It is understood and agreed that this Waiver and Release contains the complete agreement of the parties " \
        'concerning the subject matter, and supersedes any prior oral or written understandings, representations, or ' \
        'agreements pertaining thereto. This Waiver and Release and its terms are contractual and not merely a recital and ' \
        'shall be construed and governed by the laws of the State of New York, without regard to its conflicts of laws’ provisions.'
      move_down 2
      text 'I have read and understand this Waiver and Release, acknowledge the risks and liability for myself and on ' \
        'behalf of all persons of whom I am the legal guardian, and freely and voluntarily agree to its terms and conditions, ' \
        'without inducement, promise or guarantee. I am aware that by signing this document, I am knowingly and willfully ' \
        'giving up important rights, and I represent that I am the person identified below who is signing this document, ' \
        'and/or that I am the lawful parent or legal guardian of such person and have the authority to sign on his/her behalf. ' \
        'This Waiver and Release shall be binding upon and inure to the benefit of the parties, their heirs, successors, assigns' \
        'and legal representatives.'
    end

    move_down 5
    bounding_box([25, cursor], width: 520) do
      text "On this day of ____________________, 2024, I, ___________________________________________ , " \
        'of my own free will, have read, understand and acknowledge the risks and liability for myself ' \
        'and on behalf of all persons for who I am the legal guardian during the Event.'
    end

    move_down 18
    stroke do
      stroke_color '000000'
      horizontal_line 25, 240, at: cursor
    end
    font_size 9
    move_down 2
    indent 25 do
      text 'Participant Signature'
    end

    move_down 12
    stroke do
      horizontal_line 25, 240, at: cursor
      horizontal_line 290, 490, at: cursor
    end

    move_down 2
    indent 25 do
      text 'Parent/Guardian Signature' + spaces(90) + 'Printed Parent/Guardian Name'
    end
    self
  end


  def file_name
    return 'unknown_participant.pdf' if @participant_name == @unknown

    first_name, last_name = @participant_name.split
    first_name = first_name.delete('/')
    "#{last_name}_#{first_name}_2024.pdf".downcase
  end


private
  def register_fonts
    font_families.update('calibri' => {
      normal: 'app/assets/fonts/calibri.ttf'
    })
    font_families.update('calibri-bold' => {
      normal: 'app/assets/fonts/calibrib.ttf'
    })
    font_families.update('arial' => {
      normal: 'app/assets/fonts/arial.ttf'
    })
  end


  def spaces(number)
    ' ' * number
  end
end
