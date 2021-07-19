class Brand < ApplicationRecord
  has_many :teas
  validates :name, presence: true, uniqueness: true

  def self.search(search)
    if !search.blank? 
      Brand.all.where(["LOWER(name) LIKE ?","%#{search.downcase}%"])
    else 
      Brand.all
    end
  end
end
