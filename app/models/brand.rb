class Brand < ApplicationRecord
  has_many :teas
  validates :name, presence: true, uniqueness: true


  scope :by_name, ->(search) { where('name LIKE ?', "%#{search}%") }

end
