class UserAccount < ActiveRecord::Base
  has_secure_password
  has_many :participants, dependent: :destroy
  belongs_to :crew, optional: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :login, presence: true, uniqueness: { case_sensitive: false }
  validates :login, length: { minimum: 2 }, allow_blank: true 
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :email, format: { with: VALID_EMAIL_REGEX }, allow_blank: true
  validates :email, confirmation: true
  validates :email_confirmation, presence: true
  validates :password, length: { minimum: 6 }, allow_blank: true

  before_save do
    self.login.downcase!
    self.email.downcase!
  end
  before_save :create_remember_token, :generate_activation_tokens


  def initialize(attributes={})
    super(attributes)
  end


  def name
    login
  end


  def activate(code_or_token)
    (self.activation_code == code_or_token || self.activation_token == code_or_token) &&
      update_attributes!(email_confirmation: email, active: true, activated_at: Time.now)
  end


  def status
    self.active? ? 'Active' : 'Inactive'
  end


  def to_file_name
    name
  end


  def generate_reset_token
    self.reset_password_token = SecureRandom.urlsafe_base64
    self.reset_password_expired_at = Time.now
    save(validate: false)
  end


  def reset
    self.reset_password_token = nil
    self.reset_password_expired_at = nil
    save(validate: false)
  end


  def can_approve?(participant)
    # !participant.approved? && (participant.crew_lead?(self) || self.admin?)
    !participant.approved? && self.admin?
  end


  def can_confirm_payment?(participant)
    return false if participant.payment_confirmed?
    return true if self.financier? || self.admin?
    !participant.payment_received? && participant.crew_lead?(self)
  end


  def send_payment(payment)
    payment.payees.each { |payee| payee.send_payment(payment) }
  end


  def self.financier_emails
    financiers = UserAccount.where(financier: true)
    return financiers.map { |fin| fin.email }
  end


private
  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end


  def generate_activation_tokens
    self.activation_code = SecureRandom.hex[0, 6].to_i(16).to_s if self.activation_code.blank?
    self.activation_token = SecureRandom.urlsafe_base64 if self.activation_token.blank?
  end
end
