class UserAccount < ActiveRecord::Base
  has_secure_password
  has_many :participants


  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :login, presence: true, length: { minimum: 2 }, uniqueness: { case_sensitive: false }
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :email, format: { with: VALID_EMAIL_REGEX }, allow_blank: true
  validates :email, confirmation: true
  validates :email_confirmation, presence: true
  validates :password, length: { minimum: 6 }, allow_blank: true

  before_save do
    self.login.downcase!
    self.email.downcase!
  end
  before_save :create_remember_token, :generate_activation_code


  def initialize(attributes={})
    super(attributes)
  end


  def name
    login
  end


  def activate(code)
    self.activation_code == code &&
      update_attributes!(email_confirmation: email, active: true, activated_at: Time.now)
  end


private
  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end


  def generate_activation_code
    self.activation_code = SecureRandom.hex[0, 6].to_i(16).to_s if self.activation_code.blank?
  end
end
