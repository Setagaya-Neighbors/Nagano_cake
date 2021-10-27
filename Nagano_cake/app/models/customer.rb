class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :postal_code, length: {maximum: 7}
  validates :phone_number, length: {minimum: 8,maximum: 9}


  #　アソシエーション
  has_many :cart_items, dependent: :destroy
  has_many :order, dependent: :destroy
  has_many :addresses, dependent: :destroy
  #　アソシエーション

  # enum
  enum is_deleted:  { 退会: true, 有効: false }
  # enum
end
