class RemoveBrandFromBeer < ActiveRecord::Migration[6.1]
  def change
    remove_column :beers, :brand, :string
    remove_column :beers, :subbrand, :string
  end
end
