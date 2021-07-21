class Tea < ApplicationRecord
  self.inheritance_column = :_type_disabled

  belongs_to :brand
  belongs_to :user
  has_many :reviews
  has_many :users, through: :reviews
# is this right?

  validates :type, presence: true
  validates :description, presence: true
  validates :flavor, presence: true
  # will need validations for dups+brand
  validate :not_a_duplicate

  scope :by_flavor, ->(search) { where('flavor LIKE ?', "%#{search}%") }

  # user cannot make a tea with the same flavor and brand already existing
  def not_a_duplicate
    tea = Tea.find_by(flavor: flavor, brand_id: brand_id)
    if !!tea && tea != self
      errors.add(:flavor, 'has already been added for that brand of tea! Yikes!')
    end
  end

end
