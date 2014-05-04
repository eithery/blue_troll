class Participant < ActiveRecord::Base
  belongs_to :user_account

  validates :last_name, :first_name, presence: true
  validates :ticket_code, uniqueness: true, length: { minimum: 10 }
  validates :user_account, presence: true
  validates :age, presence: true, unless: Proc.new { |p| p.age_category == AgeCategory::ADULT }
  validates :age, numericality: true, allow_blank: true
  validates :email, format: { with: UserAccount::VALID_EMAIL_REGEX }, allow_blank: true


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


  def crew
    user_account.crew
  end


  def approved?
    !self.approved_at.nil?
  end


  def payment_sent?
    !self.payment_sent_at.nil?
  end


  def payment_received?
    !self.payment_received_at.nil?
  end


  def payment_confirmed?
    !self.payment_confirmed_at.nil?
  end


  def Participant.find_by_ticket(ticket_code)
    Participant.all.each { |p| return p if p.ticket_code.to_i(16).to_s == ticket_code.strip }
    nil
  end


private
  def generate_ticket_code
    self.ticket_code = SecureRandom.hex[0, 10] if self.ticket_code.blank?
  end
end
