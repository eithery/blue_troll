# Eithery Lab, 2016.
# EventParticipant model.
# Represents an event participant registration data.

class EventParticipant < ApplicationRecord
  include Trackable

  belongs_to :crew, class_name: EventCrew, inverse_of: :participants
  belongs_to :participant

  validates :crew, :participant, presence: true
  validates :ticket_code, uniqueness: true, length: { is: 10 }, if: ->(p){ p.approved? }


  def event
  end


  def approved?
    !approved_at.nil?
  end


  def checked_in?
    !checked_in_at.nil?
  end


  def unpaid?
    !payment_sent? && !payment_received? && !payment_confirmed?
  end


  def paid?
    payment_confirmed?
  end


  def payment_sent?
    !payment_sent_at.nil?
  end


  def payment_received?
    !payment_received_at.nil?
  end


  def payment_confirmed?
    !payment_confirmed_at.nil?
  end


  def approve(crew_lead)
#    update_attributes(approved_at: Time.now, approved_by: crew_lead.login)
  end


  def send_payment(payment)
#    update_attributes(payment_sent_at: Time.now, payment_sent_by: self.user_account.login,
#      payment_type: payment.payment_type, payment_notes: payment.notes)
  end


  def receive_payment(amount, crew_lead)
#    update_attributes(payment_received_at: Time.now, payment_received_by: crew_lead.login)
  end


  def confirm_payment(amount, financier)
#    update_attributes(payment_confirmed_at: Time.now, payment_confirmed_by: financier.login)
  end


  def status
    return 'Paid' if payment_confirmed?
    return 'Payment received' if payment_received?
    return 'Payment sent' if payment_sent?
    return approved? ? 'Accepted' : 'Await crew lead approval'
  end


private

  def generate_ticket_code
      self.ticket_code = SecureRandom.hex[0, 10] if ticket_code.blank?
  end
end
