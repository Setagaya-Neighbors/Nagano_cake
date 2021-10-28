class Order < ApplicationRecord
  # アソシエーション
  belongs_to :customer
  has_many :order_details, dependent: :destroy
  # アソシエーション

  # enum
  enum payment: { credit_card: 0, transfer: 1 }
  enum status:  { waiting_for_payment: 0, comfirmed: 1, on_going: 2, ready_for_shipping: 3, shipped: 4 }
  # enum

end
