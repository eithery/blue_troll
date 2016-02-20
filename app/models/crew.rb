# Eithery Lab, 2016.
# Crew model.
# Represents a crew.

class Crew < ApplicationRecord
  include NameHolder, Trackable

  belongs_to :event_type

  validates :native_name, presence: true, length: { maximum: 255 }, uniqueness: { case_sensitive: false }
  validates :location, length: { maximum: 255 }


  def full_name
    "#{name} (#{native_name})"
  end
end
