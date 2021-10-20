class Item < ApplicationRecord

  validates :name, presence: true
  validates :description, presence: true
  validates :image_id, presence: true

  attachment :image

  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy

  belongs_to :genres
end
