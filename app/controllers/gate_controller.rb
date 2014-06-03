class GateController < ApplicationController
  include GateHelper

  def checkin
  end


  def checkin_ticket
    ticket_code = params[:registration][:registration_code]
    participant = verify_ticket(ticket_code)
    if participant
      participant.registered_at = Time.now
      participant.registered_by = current_user
      participant.save!
    end
    render :checkin
  end
end
