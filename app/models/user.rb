class User < ApplicationRecord

  # name: string
  validates :name,
    length: {minimum: 1},
    allow_nil: true

  # email: string
  validates :email,
    email: true,
    allow_nil: true
end
