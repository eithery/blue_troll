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
end
