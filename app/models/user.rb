class User < ApplicationRecord
  # like sinatra, it will authenticate, validates password, readers/writers
  has_secure_password

  has_many :reviews
  has_many :reviewed_teas, through: :reviews, source: :tea
  has_many :teas 
  # has many brands through teas? should I show both relationships?

  # validations 
  validates :email, presence: true, :uniqueness => { :case_sensitive => false }
  validates :username, presence: true
  validates :email, presence: true, 'valid_email_2/email': true

  
  end