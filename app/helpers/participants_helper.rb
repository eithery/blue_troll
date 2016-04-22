module ParticipantsHelper
  def all_crews
    Crew.order(:name)
  end


  def form_header
#    crew = @participant.requested_crew_id.blank? ? @participant.crew : Crew.find(@participant.requested_crew_id)
    "#{@participant.new_record? ? "New" : "Edit"} Participant"
  end


  def approve_tag(participant, index)
    if current_user.can_approve?(participant)
      link_to 'Accept', approve_path(id: participant, index: index), class: "btn btn-success btn-xs",
        remote: true, data: { confirm: "Do you want to accept #{participant.display_name} to your crew?" }
    end
  end


  def confirm_payment_tag(participant, index)
    if participant.approved? && current_user.can_confirm_payment?(participant)
      link_to 'Paid', confirm_payment_path(participant_id: participant, index: index),
        class: "btn btn-warning btn-xs", method: :post, remote: true,
        data: { confirm: "Do you want to confirm payment for #{participant.display_name}?" }
    end
  end


  def send_ticket_link_tag(participant)
    if participant.payment_confirmed?
      link_to image_tag('send_ticket_link.png', alt: 'Email with download ticket link', class: "bt-img bt-img-reduced"),
        send_ticket_link_path(participant), method: :post,
        title: "Click here to send email to #{participant.display_name} with link to the ticket.", rel: 'tooltip'
    end
  end


  def delete_tag(participant)
    if !participant.payment_confirmed? || current_user.admin?
      link_to image_tag('delete.png', alt: 'Delete participant', class: "bt-img"),
        participant_path(participant), method: :delete, rel: 'tooltip',
        title: "Click here to delete #{participant.display_name} from Blue Trolley participants list",
        data: { confirm: "Are you sure to delete #{participant.display_name} from the participants list?" }
    end
  end


  def crew_lead_image(participant)
    if participant.user_account.crew_lead? && participant.primary?
      image_tag 'crew_lead.png', class: "bt-img-reduced", style: "margin-left: 0.25em; margin-bottom: 0.2em;"
    end
  end


  def age_category(participant)
    age = participant.age || 0
    age = participant.baby? ? '?' : '' if age == 0

    return "B#{age}" if participant.baby?
    return "C#{age}" if participant.child?
    return "A#{age}"
  end


  def cancel_add_participant_path(participant)
    return participant.user_account if participant.requested_crew_id.blank?
    Crew.find(participant.requested_crew_id)
  end


  def participant_class(participant)
    return 'warning' if participant.flagged?
    return 'success' if participant.checked_in?
    ''
  end
end
