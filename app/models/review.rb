class Review < ApplicationRecord
  belongs_to :user
  belongs_to :tea

  validates :title, presence: true
  validates :text, length: { minimum: 15} # say something short at least


  # if the review has already been reviewed by the user then they cannot review it again 
  validates :tea, uniqueness: { scope: :user, message: "has already been reviewed by you! Go review another tea or edit your review :)"  }
end
