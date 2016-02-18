# Eithery Lab, 2016.
# EventCrew model.
# Represents a crew in the particular event.

class EventCrew < ApplicationRecord
  include Trackable

  belongs_to :crew
  belongs_to :event, inverse_of: :crews
  has_many :participants, class_name: EventParticipant

  validates :event, :crew, presence: true
end
