class Brand < ApplicationRecord
  has_many :teas
  # should I add a has many users through teas?
  validates :name, presence: true, uniqueness: true
end
