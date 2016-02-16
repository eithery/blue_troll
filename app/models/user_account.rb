# Eithery Lab, 2016.
# UserAccount model.
# Represents a user account.

class UserAccount < ApplicationRecord
  include Trackable

  attr_accessor :remember_token

  has_secure_password
  has_many :participants, dependent: :destroy
  belongs_to :crew, required: false

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :login, presence: true, uniqueness: { case_sensitive: false }
  validates :login, length: 4..255, allow_blank: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :email, format: { with: VALID_EMAIL_REGEX }, allow_blank: true
  validates :email, confirmation: true
  validates :email_confirmation, presence: true
  validates :password, presence: true
  validates :password, length: 6..72, allow_blank: true

  before_save do
    self.login.downcase!
    self.email.downcase!
  end


  def name
    login
  end


  def to_file_name
    name
  end


  def remember
    self.remember_token = UserAccount.new_token
    update_attribute(:remember_digest, UserAccount.digest(remember_token))
  end


  def forget
    self.remember_token = nil
    update_attribute(:remember_digest, nil)
  end


  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest) == remember_token
  end


private

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end


  def self.new_token
    SecureRandom.urlsafe_base64
  end
end

=begin
  def activate(code_or_token)
    (self.activation_code == code_or_token || self.activation_token == code_or_token) &&
      update_attributes!(email_confirmation: email, active: true, activated_at: Time.now)
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


  def can_approve?(participant, event)
    (lead_of?(participant.crew) || admin?) && !participant.approved?
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
  def generate_activation_tokens
    self.activation_code = SecureRandom.hex[0, 6].to_i(16).to_s if self.activation_code.blank?
    self.activation_token = SecureRandom.urlsafe_base64 if self.activation_token.blank?
  end
=end
