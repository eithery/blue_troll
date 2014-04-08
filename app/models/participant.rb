class Participant < ActiveRecord::Base
  belongs_to :user_account
  belongs_to :crew

  validates :last_name, :first_name, presence: true
  validates :ticket_code, uniqueness: true, length: { minimum: 10 }
  validates :crew, :user_account, presence: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, format: { with: VALID_EMAIL_REGEX }, allow_blank: true


  def initialize(attributes={})
    super(attributes)
    generate_ticket_code
  end


  def full_name
    "#{last_name}, #{first_name}"
  end


  def display_name
    "#{first_name} #{last_name}"
  end


  def email
    return self[:email] unless self[:email].blank?
    return user_account.email unless user_account.nil?
    nil
  end


  def Participant.find_by_ticket(ticket_code)
    Participant.all.each do |participant|
      return participant if participant.ticket_code.to_i(16).to_s == ticket_code.strip
      return participant if participant.reservation_number.to_s == ticket_code.strip
    end
    nil
  end


private
  def generate_ticket_code
    self.ticket_code = SecureRandom.hex[0, 10] if self.ticket_code.blank?
  end
end
