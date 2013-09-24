module RegistrationHelper
  def verify_ticket(ticket_code)
    if ticket_code.blank?
      flash.now[:error] = "Registration code is not entered."
      return false
    end

    participant = Participant.find_by_ticket(ticket_code)
    if participant.nil?
      flash.now[:error] = "Participant with code '#{ticket_code}' is not registered."
      return false
    else
      flash.now[:success] = "#{participant.full_name}, Welcome to Blue Trolley event!"
      return participant
    end
  end
end
