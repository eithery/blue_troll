class RegistrationController < ApplicationController
  include RegistrationHelper


  def checkin
  end


  def check_ticket
    ticket_code = params[:registration][:registration_code]
    check ticket_code
    render 'checkin'
  end
end
