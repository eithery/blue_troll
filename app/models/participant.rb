class Participant < ActiveRecord::Base
	validates :last_name, :first_name, presence: true
  validates :last_name, uniqueness: { :scope => :first_name }
  validates :ticket_code, presence: true, length: { maximum: 20 }, uniqueness: true

  belongs_to :crew
end
