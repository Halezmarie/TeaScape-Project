class Brand < ApplicationRecord
  has_many :teas
  has_many :users, through: :teas
  validates :name, presence: true, uniqueness: true
  validates_uniqueness_of :name, :case_sensitive => false
  before_validation :format_values

  scope :by_name, ->(search) { where('name LIKE ?', "%#{search}%") }

  def format_values
    self.name = self.name.titleize.strip
  end
end
