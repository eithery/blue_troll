# Eithery Lab, 2016.
# EventParticipant model.
# Represents an event participant registration data.

class EventParticipant < ApplicationRecord
  include Trackable

  belongs_to :crew, class_name: EventCrew, foreign_key: :event_crew_id, inverse_of: :participants
  belongs_to :person, class_name: Participant, foreign_key: :participant_id

  validates :ticket_code, uniqueness: { case_sensitive: false }, length: { is: 10 }, if: ->(p){ p.approved? }

  AWAITING_APPROVAL = 'Await crew lead approval'
  ACCEPTED = 'Accepted'
  PAYMENT_SENT = 'Payment sent'
  PAYMENT_RECEIVED = 'Payment received'
  PAYMENT_CONFIRMED = 'Paid'

  enum payment_type: [:paypal, :check, :cash, :other]


  def event
    crew.event
  end


  def name
    person.display_name
  end


  def user
    person.user_account
  end


  def email
    person.email
  end


  def approved?
    !approved_at.nil?
  end


  def checked_in?
    !checked_in_at.nil?
  end


  def unpaid?
    !paid?
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


  def approve(approver)
    validate_crew_lead approver, 'Approver'
    generate_ticket_code
    update_attributes(ticket_code: ticket_code, approved_at: Time.now, approved_by: approver.name)
  end


  def send_payment(payment)
    update_attributes(payment_sent_at: Time.now, payment_sent_by: payment.payer.name,
      payment_type: payment.payment_type, payment_notes: payment.notes)
  end


  def receive_payment(receiver)
    validate_crew_lead receiver, 'Payment receiver'
    update_attributes(payment_received_at: Time.now, payment_received_by: receiver.name)
  end


  def confirm_payment(confirmer)
    validate_financier confirmer
    update_attributes(payment_confirmed_at: Time.now, payment_confirmed_by: confirmer.name)
  end


  def status
    return PAYMENT_CONFIRMED if payment_confirmed?
    return PAYMENT_RECEIVED if payment_received?
    return PAYMENT_SENT if payment_sent?
    return approved? ? ACCEPTED : AWAITING_APPROVAL
  end


private

  def generate_ticket_code
      self.ticket_code = SecureRandom.hex[0, 10] if ticket_code.blank?
  end


  def validate_crew_lead(crew_lead, title)
    raise Exceptions::InvalidCrewLeadError, 'Crew lead is not specified' if crew_lead.blank?
    raise Exceptions::InvalidCrewLeadError, "#{title} is not a crew lead" unless crew_lead.crew_lead?
    raise Exceptions::InvalidCrewLeadError, 'Crew lead belongs to another crew' if crew_lead.crew != crew
  end


  def validate_financier(financier)
    raise Exceptions::InvalidFinancierError, 'Financier is not specified' if financier.blank?
    raise Exceptions::InvalidFinancierError, 'Payment confirmer is not a financier' unless financier.financier?
  end
end
