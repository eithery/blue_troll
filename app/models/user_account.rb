class UserAccount < ActiveRecord::Base
  has_secure_password

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :email, format: { with: VALID_EMAIL_REGEX }, allow_blank: true
  validates :email, confirmation: true
  validates :password, length: { minimum: 6 }, allow_blank: true

  before_save { self.email.downcase! }
  before_save :create_remember_token


private
  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end
end
