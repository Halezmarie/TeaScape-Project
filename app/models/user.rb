class User < ApplicationRecord
  # like sinatra, it will authenticate, validates password, readers/writers
  has_secure_password

  has_many :reviews
  has_many :reviewed_teas, through: :reviews, source: :tea
  has_many :teas
  has_many :brands, through: :teas
  

  # validations 
  validates :email, uniqueness: true 
  validates :username, presence: true
  validates :email, presence: true, 'valid_email_2/email': true



  end