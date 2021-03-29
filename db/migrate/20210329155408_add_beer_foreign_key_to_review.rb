class AddBeerForeignKeyToReview < ActiveRecord::Migration[6.1]
  def change
    add_reference :reviews, :beer, foreign_key: true
  end
end
