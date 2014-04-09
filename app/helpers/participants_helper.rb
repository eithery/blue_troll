module ParticipantsHelper
  def all_crews
    Crew.order(:name)
  end


  def form_header
    "#{@participant.new_record? ? "New" : "Edit"} Participant"
  end


  def baby_image(participant)
    image_tag("baby.png", class: "bt-img-reduced") if participant.category == :baby
  end


  def red_flag_image(participant)
    image_tag("red_flag.png", class: "bt-img") if participant.flagged?
  end


  def participant_here_image(participant)
    image_tag participant.registered_at.blank? ? 'bulb_off.png' : 'bulb_on.png'
  end
end
