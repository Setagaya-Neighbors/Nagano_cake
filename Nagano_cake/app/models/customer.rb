class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :postal_code, length: {is: 7}
  validates :phone_number, length: {minimum: 8,maximum: 10}


  #　アソシエーション
  has_many :cart_items, dependent: :destroy
  has_many :order, dependent: :destroy
  has_many :addresses, dependent: :destroy
  #　アソシエーション

  # enum
  enum is_deleted:  { 退会: true, 有効: false }
  # enum

  # 姓、名を連結して表示（order#comfirmで使用）
  def name
    self.last_name + " " + self.first_name
  end
  # 姓、名を連結して表示（order#comfirmで使用）
end
