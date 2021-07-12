class Review < ApplicationRecord
  belongs_to :user
  belongs_to :tea

  validates :title, presence: true
  validates :text, length: { minimum: 15} # say something short at least
  # validations for stars etc,

  # add scope here 
end
