# Eithery Lab, 2016.
# Event model.
# Represents the organizational event (Blue Trolley, party, concert).

class Event < ApplicationRecord
  include NameHolder, Trackable, Statistics

  belongs_to :event_type
  has_many :crews, class_name: EventCrew, dependent: :restrict_with_exception
  has_many :participants, through: :crews, class_name: EventParticipant

  validates :short_name, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 20 }
  validates :started_on, :finished_on, presence: true
  validates :address, presence: true, length: { maximum: 255 }

  validate :dates_mismatch


  def participant_by_ticket(ticket_code)
    return nil if ticket_code.blank?
    participants.find { |p| !p.ticket_code.blank? && p.ticket_code.to_i(16).to_s == ticket_code.strip }
  end


  def crew_leads
    participants.select { |p| p.crew_lead? }
  end


  def crew_lead_emails
    crew_leads.map { |lead| lead.email }
  end


  def financiers
    participants.select { |p| p.financier? }
  end


  def financier_emails
    financiers.map { |fin| fin.email }
  end


  def gatekeepers
    participants.select { |p| p.gatekeeper? }
  end

private

  def dates_mismatch
    if !started_on.nil? && !finished_on.nil? && started_on > finished_on
      errors[:base] << "Event start date can't be later than end date"
    end
  end
end
