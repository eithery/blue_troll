module CrewsHelper
  def crew_leads(crew)
    crew.leads.map { |lead| lead.login }.join(', ')
  end

  def crew_emails(crew)
    crew.emails.join(', ')
  end
end
