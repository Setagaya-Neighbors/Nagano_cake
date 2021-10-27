class CartItem < ApplicationRecord
  # アソシエーション
  belongs_to :customer
  belongs_to :item
  # アソシエーション

  # 価格の合計
  def sum_of_price
    item.price.to_i * self.quantity>to_i * 1.08
  end
  # /価格の合計

end