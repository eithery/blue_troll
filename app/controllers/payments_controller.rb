class PaymentsController < ApplicationController
  before_filter :signed_in_user, only: [:send_payment, :confirm_payment]
  before_filter :correct_user, only: [:send_payment]


  def send_payment
    payment = Payment.new(@user, params[:payment])
    @user.send_payment(payment)
    PaymentsMailer.payment_sent(@user, payment).deliver
    flash[:success] = "Payment notification has been sent to the crew lead and financier."
    redirect_to @user
  end


  def confirm_payment
    @participant = Participant.find(params[:participant_id])
    @index = params[:index]
    @participant.update_attributes(payment_received_at: Time.now, payment_received_by: current_user.login)
    respond_to do |format|
      format.html { redirect_to crew_path(current_user.crew) }
      format.js
    end
  end
end
