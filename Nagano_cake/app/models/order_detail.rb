class OrderDetail < ApplicationRecord
  # アソシエーション
  belongs_to :order
  belongs_to :item
  # アソシエーション

  # enum
  enum making_status: { impossible: 0, waiting_for_cooking: 1, on_going: 2, complete: 3 }
  # enum


end
