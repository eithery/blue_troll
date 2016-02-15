# Eithery Lab, 2016.
# Event model.
# Represents Blue Trolley event.

class Event < ApplicationRecord
  validates :name, :started_on, :finished_on, :address, presence: true
end
