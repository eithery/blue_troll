module RegistrationHelper
  def check(ticket_code)
    return flash.now[:error] = "Registration code is not entered." if ticket_code.blank?

    participant = Participant.find_by_ticket(ticket_code)

    return flash.now[:success] = "#{participant.full_name}, Welcome to Blue Trolley event!" unless participant.nil?
    return flash.now[:error] = "Participant with code '#{ticket_code}' is not registered." if participant.nil?
  end
end
