class RegistrationController < ApplicationController
  include RegistrationHelper


  def checkin
  end


  def check_ticket
    ticket_code = params[:registration][:registration_code]
    participant = verify_ticket(ticket_code)
    unless participant.nil?
      participant.registered_at = Time.now
      participant.registered_by = 'gatekeeper'
      participant.save!
    end
    render 'checkin'
  end
end
