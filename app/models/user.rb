class User < ApplicationRecord
  has_secure_password

  # name: string
  validates :name, length: {minimum: 1}, allow_nil: true

  # email: string
  validates :email, presence: true, email: true, uniqueness: true
end
