class Address < ApplicationRecord
 # アソシエーション
  belongs_to :customer
  has_many :cart_item
 # アソシエーション

end
