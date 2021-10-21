class OrderDetail < ApplicationRecord
  # アソシエーション
  belongs_to :order
  belongs_to :item
  # アソシエーション

  # enum
  enum making_status: { 着手不可: 0, 製作待ち: 1, 製作中: 2, 製作完了: 3 }
  # enum


end