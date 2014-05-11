module ParticipantsHelper
  def all_crews
    Crew.order(:name)
  end


  def form_header
    "#{@participant.new_record? ? "New" : "Edit"} Participant"
  end


  def approve_tag(participant, index)
    link_to 'Accept', approve_path(id: participant, index: index), class: "btn btn-success btn-xs",
      remote: true if current_user.can_approve? participant
  end


  def send_payment_tag(participant)
    link_to 'Pay', '#', class: "btn btn-success btn-xs" if participant.approved? && participant.unpaid? &&
      !current_user.can_confirm_payment?(participant)
  end


  def confirm_payment_tag(participant)
    link_to 'Paid', '#', class: "btn btn-warning btn-xs" if current_user.can_confirm_payment? participant
  end


  def download_ticket_tag(participant)
    if participant.payment_confirmed?
      link_to image_tag('ticket.png', alt: 'Download ticket', class: "bt-img bt-img-reduced"),
        participant_ticket_path(participant_id: participant), 
        title: "Click here to download a ticket for #{participant.display_name}", rel: 'tooltip'
    end
  end


  def edit_tag(participant)
    link_to image_tag('edit.png', alt: 'Edit participant', class: "bt-img"),
      edit_participant_path(participant), title: "Click here to edit #{participant.display_name} profile",
      rel: 'tooltip'
  end


  def delete_tag(participant)
    unless participant.payment_confirmed?
      link_to image_tag('delete.png', alt: 'Delete participant', class: "bt-img"),
        participant_path(participant), method: :delete, rel: 'tooltip',
        title: "Click here to delete #{participant.display_name} from Blue Trolley participants list",
        data: { confirm: "Are you sure to delete #{participant.display_name} from the participants list?" }
    end
  end
end
