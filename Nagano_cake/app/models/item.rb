class Item < ApplicationRecord

  validates :name, {presence: true, lengh: {maximum: 20}}
  validates :description, {presence: true, lengh: {maximum: 50}}
  validates :image_id, presence: true

  attachment :image

  #　アソシエーション
  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy

  belongs_to :genres
  #　アソシエーション


  # enum
  enum is_active:  { 販売中: false, 販売停止中: true }
  # enum

end
