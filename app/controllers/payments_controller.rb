class PaymentsController < ApplicationController
  before_filter :signed_in_user, only: [:send_payment]
  before_filter :correct_user, only: [:send_payment]


  def send_payment
    payment = Payment.new(@user, params[:payment])
    @user.send_payment(payment)
    PaymentsMailer.payment_sent(@user, payment).deliver
    flash[:success] = "Payment notification has been sent to the crew lead and financier."
    redirect_to @user
  end


  def receive_payment
  end


  def confirm_payment
  end
end
