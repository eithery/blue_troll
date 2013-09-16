class Crew < ActiveRecord::Base
  validates :name, :native_name, presence: true, uniqueness: true

  has_many :participants
end
