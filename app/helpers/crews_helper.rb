module CrewsHelper
  def crew_leads(crew)
    crew.leads.map { |lead| lead.login }.join(', ')
  end


  def crew_emails(crew)
    crew.emails.join(', ')
  end


  def show_participants_tag(crew)
    link_to image_tag('participants.png', alt: 'Participants', class: "bt-img bt-img-reduced"),
      crew_path(crew), title: 'Click here to see all participants in the crew.', rel: 'tooltip'
  end


  def add_participant_tag(crew)
    link_to image_tag('new_participant.png', alt: 'Add Participant', class: "bt-img bt-img-reduced"),
      new_participant_path(crew_id: crew.id), title: 'Click here to add a new participant.', rel: 'tooltip'
  end


  def download_tickets_tag(crew)
    link_to image_tag('ticket.png', alt: 'Generate ticket', class: "bt-img bt-img-reduced"),
      crew_tickets_download_path(crew), title: 'Click here to download tickets for the crew.', rel: 'tooltip',
      method: :post
  end


  def totals(crew)
    "#{crew.total_participants} (#{crew.total_adults}/#{crew.total_children}/#{crew.total_babies})"
  end
end
