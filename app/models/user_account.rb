class UserAccount < ActiveRecord::Base
  has_secure_password

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, confirmation: true, uniqueness: { case_sensitive: false }
  validates :email_confirmation, presence: true
  validates :password, length: { minimum: 6 }

  before_save { self.email.downcase! }
  before_save :create_remember_token


private
  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end
end
