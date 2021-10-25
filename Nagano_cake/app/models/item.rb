class Item < ApplicationRecord

  validates :name, {presence: true, length: {maximum: 20}}
  validates :description, {presence: true, length: {maximum: 50}}
  validates :image, presence: true

  attachment :image

  #　アソシエーション
  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy

  belongs_to :genre
  #　アソシエーション


  # enum
  enum is_active:  { 販売中: false, 販売停止中: true }
  # enum

end
