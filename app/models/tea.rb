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
end
