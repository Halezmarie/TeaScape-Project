class Tea < ApplicationRecord
  self.inheritance_column = :_type_disabled

  belongs_to :brand
  belongs_to :user
  has_many :reviews
  has_many :users, through: :reviews

  validates :type, presence: true
  validates :description, presence: true
  validates :flavor, presence: true

  validate :not_a_duplicate
  before_validation :format_values

  scope :by_flavor, ->(search) { where('flavor LIKE ?', "%#{search}%") }

  def not_a_duplicate
    tea = Tea.find_by(flavor: flavor, brand_id: brand_id) 
    if !!tea && tea != self 
      errors.add(:flavor, 'has already been added for that brand of tea! Yikes!')
    end
  end
 
  def format_values
    self.flavor = self.flavor.titleize.strip
    self.description = self.description.capitalize
    self.type = self.type.capitalize
  end

end
