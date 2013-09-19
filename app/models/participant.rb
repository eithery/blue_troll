class Participant < ActiveRecord::Base
	validates :last_name, :first_name, presence: true
  validates :last_name, uniqueness: { :scope => :first_name }
  validates :ticket_code, presence: true, uniqueness: true, length: { is: 20 }
  validates :crew, presence: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, format: { with: VALID_EMAIL_REGEX }

  belongs_to :crew

  def initialize(attributes={})
    super(attributes)
    generate_ticket_code
  end


  def full_name
    "#{last_name}, #{first_name}"
  end


private
  def generate_ticket_code
    self.ticket_code = SecureRandom.hex[0, 20] if self.ticket_code.blank?
  end
end
