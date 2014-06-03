module GateHelper
  def verify_ticket(ticket_code)
    if ticket_code.blank?
      flash.now[:error] = "Ticket code is not entered."
      return false
    end

    participant = Participant.find_by_ticket(ticket_code)
    if participant.nil?
      flash.now[:error] = "Participant with ticket code '#{ticket_code}' is not registered."
      return false
    else
      if participant.registered_at.nil?
        flash.now[:success] = "#{participant.full_name}, Welcome to Blue Trolley event!"
        return participant
      else
        flash.now[:notice] = "Participant #{participant.full_name} already registered."
        return false
      end
    end
  end
end
