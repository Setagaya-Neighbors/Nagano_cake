class Address < ApplicationRecord
 # アソシエーション
  belongs_to :customer
 # アソシエーション

  # 郵便番号、住所、名前を結合して、配送先入力欄の候補に表示
    def full_address
      "〒" + self.postal_code + " " + self.address + " " + self.name
    end
  # /郵便番号、住所、名前を結合して、配送先入力欄の候補に表示

end
