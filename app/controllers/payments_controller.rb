class PaymentsController < ApplicationController
  before_action :signed_in_user, only: [:send_payment, :confirm_payment]
  before_action :correct_user, only: [:send_payment]


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
    if current_user.financier? || current_user.admin?
      @participant.update(payment_confirmed_at: Time.now, payment_confirmed_by: current_user.login)
    else
      @participant.update(payment_received_at: Time.now, payment_received_by: current_user.login)
    end
    respond_to do |format|
      format.html { redirect_to crew_path(current_user.crew) }
      format.js
    end
  end
end
