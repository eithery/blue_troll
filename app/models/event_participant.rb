class EventParticipant < ApplicationRecord
  validates :ticket_code, :uniqueness: true, length: { minimum: 10 }
end
