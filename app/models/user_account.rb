# Eithery Lab, 2016.
# UserAccount model.
# Represents a user account.

class UserAccount < ApplicationRecord
  include Trackable

  attr_accessor :remember_token, :activation_token

  has_secure_password
  has_many :participants, dependent: :destroy
  alias_method :persons, :participants

  before_save :downcase_credentials
  before_create :create_activation_digest

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :login, presence: true, uniqueness: { case_sensitive: false }
  validates :login, length: 4..255, allow_blank: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :email, format: { with: VALID_EMAIL_REGEX }, allow_blank: true
  validates :email, confirmation: true
  validates :email_confirmation, presence: true
  validates :password, presence: true
  validates :password, length: 6..72, allow_blank: true


  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
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


  def can_approve?(participant)
#    !participant.approved? && (lead_of?(participant.crew) || admin?)
  end


  def can_confirm_payment?(participant)
#    return false if participant.payment_confirmed?
#    return true if self.financier? || self.admin?
#    !participant.payment_received? && participant.crew_lead?(self)
  end


private

  def self.new_token
    SecureRandom.urlsafe_base64
  end


  def create_activation_digest
    self.activation_token = UserAccount.new_token
    self.activation_digest = UserAccount.digest(activation_token)
  end


  def downcase_credentials
    self.login.downcase!
    self.email.downcase!
  end
end
