class User < ApplicationRecord
  # like sinatra, it will authenticate, validates password, readers/writers
  has_secure_password

  has_many :reviews
  has_many :reviewed_teas, through: :reviews, source: :tea
  has_many :teas 
  # has many brands through teas? should I show both relationships?

  # validations 
  validates :username, uniqueness: true,  presence: true
  validates :email, presence: true
  end