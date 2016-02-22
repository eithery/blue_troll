# Eithery Lab, 2016.
# Event model.
# Represents the organizational event (Blue Trolley, party, concert).

class Event < ApplicationRecord
  include NameHolder, Trackable

  belongs_to :event_type
  has_many :crews, class_name: EventCrew, dependent: :restrict_with_exception
  has_many :participants, through: :crews, class_name: EventParticipant

  validates :started_on, :finished_on, presence: true
  validates :address, presence: true, length: { maximum: 255 }

  validate :dates_mismatch


  def participant_by_ticket(ticket_code)
    participants.find { |p| p.ticket_code.to_i(16).to_s == ticket_code.strip }
  end


  def crew_leads
  end


  def crew_lead_emails
  end


  def financiers
    participants.select { |p| p.financier? }
  end


  def financier_emails
  end


  def gatekeepers
  end


  def statistics
  end

private

  def dates_mismatch
    if !started_on.nil? && !finished_on.nil? && started_on > finished_on
      errors[:base] << "Event start date can't be later than end date"
    end
  end
end
