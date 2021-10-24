class CartItem < ApplicationRecord
  # アソシエーション
  belongs_to :customer
  belongs_to :item
  # アソシエーション

  # 価格の合計
  def sum_of_price
    item.price * quantity
  end
  # /価格の合計

end