class Beer < ApplicationRecord
    belongs_to :brand
    has_many :review
end
