class Address < ApplicationRecord
 # アソシエーション
  belongs_to :customer


  validates :postal_code, length: {is: 7}

end
