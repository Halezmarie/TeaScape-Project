class User < ApplicationRecord
  #like sinatra, it will authenticate, validates password, readers/writers
    has_secure_password
  end