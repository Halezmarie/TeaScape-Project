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


  # user cannot make a tea with the same flavor and brand already existing
  def not_a_duplicate
    tea = Tea.find_by(flavor: flavor, brand_id: brand_id) # setting variables 
    if !!tea && tea != self # if the tea flavors match with a flavor that is already in the brand then it will throw an error
      errors.add(:flavor, 'has already been added for that brand of tea! Yikes!')
    end
  end

  # refactor this 
  def format_values
    self.flavor = self.flavor.titleize.strip
    self.description = self.description.capitalize
    self.type = self.type.capitalize
  end

end
