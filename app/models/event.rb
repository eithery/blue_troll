# Eithery Lab, 2016.
# Event model.
# Represents Blue Trolley event.

class Event < ApplicationRecord
  include NameHolder, Trackable

  validates :started_on, :finished_on, presence: true
  validates :address, presence: true, length: { maximum: 255 }
end
