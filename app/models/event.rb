# Eithery Lab, 2016.
# Event model.
# Represents Blue Trolley event.

class Event < ApplicationRecord
  include NameHolder, Trackable

  belongs_to :event_type
  has_many :crews, class_name: EventCrew
  has_many :participants, class_name: EventParticipant

  validates :event_type, :started_on, :finished_on, presence: true
  validates :address, presence: true, length: { maximum: 255 }


  def participant_by_ticket(ticket_code)
#    Participant.all.each { |p| return p if p.ticket_code.to_i(16).to_s == ticket_code.strip }
  end
end
