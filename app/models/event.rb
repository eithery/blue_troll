# Eithery Lab, 2016.
# Event model.
# Represents Blue Trolley event.

class Event < ApplicationRecord
  include NameHolder, Trackable

  belongs_to :event_type

  validates :event_type, :started_on, :finished_on, presence: true
  validates :address, presence: true, length: { maximum: 255 }
end
