# Eithery Lab, 2016.
# UserAccount model.
# Represents a user account.

class UserAccount < ApplicationRecord
  include Trackable

  attr_accessor :remember_token, :activation_token, :reset_token

  has_secure_password
  has_many :participants, dependent: :destroy
  alias_method :persons, :participants

  before_save :downcase_credentials
  before_create :create_activation_digest

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :login, presence: true, uniqueness: { case_sensitive: false }
  validates :login, length: 6..255, allow_blank: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :email, format: { with: VALID_EMAIL_REGEX }, allow_blank: true
  validates :email, confirmation: true
  validates :email_confirmation, presence: true
  validates :password, presence: true
  validates :password, length: 8..72, allow_blank: true


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
    update_attribute :remember_digest, UserAccount.digest(remember_token)
  end


  def forget
    self.remember_token = nil
    update_attribute :remember_digest, nil
  end


  def activate
    update_attribute :activated, true
    update_attribute :activated_at, Time.zone.now
  end


  def create_reset_digest
    self.reset_token = UserAccount.new_token
    update_attribute :reset_digest, UserAccount.digest(reset_token)
    update_attribute :reset_sent_at, Time.zone.now
  end


  def send_activation_email
    UserAccountsMailer.account_activation(self).deliver_now
  end


  def send_password_reset_email
    UserAccountsMailer.password_reset(self).deliver_now
  end


  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest) == token
  end


  def can_approve?(participant)
    !participant.approved? && (admin? || crew_lead_for?(participant))
  end


  def can_receive_payment_of?(participant)
    !participant.payment_received? && (admin? || financier_for?(participant) || crew_lead_for?(participant))
  end


  def can_confirm_payment_of?(participant)
    !participant.payment_confirmed? && (admin? || financier_for?(participant))
  end


  def financier_at?(event)
    event.financiers.any? { |fin| fin.user == self }
  end


  def financier_for?(participant)
    financier_at? participant.event
  end


  def crew_lead_of?(crew)
    crew.leads.any? { |lead| lead.user == self }
  end


  def crew_lead_for?(participant)
    crew_lead_of? participant.crew
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
