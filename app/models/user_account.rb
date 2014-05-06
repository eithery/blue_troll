class UserAccount < ActiveRecord::Base
  has_secure_password
  has_many :participants, dependent: :destroy
  belongs_to :crew

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


  def generate_reset_token
    update_attributes(reset_password_token: SecureRandom.urlsafe_base64, reset_password_expired_at: Time.now)
  end


  def reset
    update_attributes(reset_password_token: nil, reset_password_expired_at: nil)
  end


  def can_approve?(participant)
    !participant.approved? && participant.crew_lead?(self)
  end


  def can_confirm_payment?(participant)
    return false if participant.payment_confirmed?
    self.financier? || participant.payment_sent? && !participant.payment_received? && participant.crew_lead?(self) 
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
