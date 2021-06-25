class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.string :text
      t.string :title
      t.integer :stars
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :tea, null: false, foreign_key: true

      t.timestamps
    end
  end
end
