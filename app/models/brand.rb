class Brand < ApplicationRecord
  has_many :teas
  has_many :users
  validates :name, presence: true, uniqueness: true
  validates_uniqueness_of :name, :case_sensitive => false

  scope :by_name, ->(search) { where('name LIKE ?', "%#{search}%") }

  

end
