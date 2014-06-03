module GateHelper
  def verify_ticket(ticket_code)
    if ticket_code.blank?
      flash.now[:warning] = "Ticket code is not entered."
      return false
    end

    participant = Participant.find_by_ticket(ticket_code)
    if participant.nil?
      flash.now[:danger] = "Participant with ticket code '#{ticket_code}' is not registered."
      return false
    else
      if participant.registered_at.nil?
        flash.now[:success] = "#{participant.display_name}, Welcome to Blue Trolley event!"
        return participant
      else
        flash.now[:warning] = "Participant #{participant.display_name} already checked in."
        return false
      end
    end
  end
end
