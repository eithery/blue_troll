# Eithery Lab, 2016.
# Participant model.
# Represents a participant personal info.

class Participant < ApplicationRecord
  include Trackable

  belongs_to :user_account, inverse_of: :participants
  before_destroy :delete_event_participants

  validates :last_name, :first_name, :age_category, presence: true
  validates :age, presence: true, unless: Proc.new { |p| p.adult? }
  validates :age, numericality: true, allow_blank: true
  validates :email, format: { with: UserAccount::VALID_EMAIL_REGEX }, allow_blank: true

  enum age_category: [:adult, :child, :baby]
  enum gender: [:female, :male]


  def full_name
    "#{last_name}, #{first_name}"
  end


  def display_name
    "#{first_name} #{last_name}"
  end


  def email
    self[:email].blank? ? user_account&.email : self[:email]
  end


private

  def delete_event_participants
    EventParticipant.destroy_all(participant_id: id)
  end
end
