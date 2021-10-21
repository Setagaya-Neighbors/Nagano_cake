class Order < ApplicationRecord
  # アソシエーション
  belongs_to :customer
  has_many :order_details, dependent: :destroy
  # アソシエーション

  # enum
  enum payment: { クレジットカード: 0, 銀行振込: 1 }
  enum status:  { 入金待ち: 0, 入金確認: 1, 製作中: 2, 製作準備中: 3, 発送準備中: 4, 発送済み: 5 }
  # enum

end