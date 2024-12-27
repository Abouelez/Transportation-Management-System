class User < ApplicationRecord
  has_secure_password


  validates :name, presence: true,  length: { minimum: 5, maximum: 50, message: "name must be more than 5 chars and less than 50 chars." }
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: URI::MailTo::EMAIL_REGEXP, message: "Invalid email address." }
  validates :password, presence: true, length: { minimum: 8 }
  validates_confirmation_of :password
  validates :password_confirmation, presence: true
end
