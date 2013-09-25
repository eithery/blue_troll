module ParticipantsHelper
  def redirect_by_cancel
    return participants_path(crew_id: @participant.crew_id) unless @participant.crew_id.nil?
    return crews_path
  end


  def all_crews
    Crew.order(:name)
  end


  def form_header
    "#{@participant.new_record? ? "New" : "Edit"} Participant"
  end


  def participant_image(participant)
    image_tag("baby.png", class: "bt-img-reduced") if participant.category == :baby
  end


  def participant_here_image(participant)
    image_tag participant.registered_at.blank? ? 'bulb_off.png' : 'bulb_on.png'
  end
end
