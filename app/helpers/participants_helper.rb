module ParticipantsHelper
  def all_crews
    Crew.order(:name)
  end


  def form_header
    "#{@participant.new_record? ? "New" : "Edit"} Participant"
  end


  def approve_tag(participant)
    link_to 'Accept', '#', class: "btn btn-success btn-xs" if can_approve? participant
  end


private
  def can_approve?(participant)
    current_user.crew_lead? && !participant.approved?
  end
end
