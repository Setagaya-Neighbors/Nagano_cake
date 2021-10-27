class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # 姓、名を連結して表示（order#comfirmで使用）
  def name
    self.last_name + " " + self.first_name
  end
  # 姓、名を連結して表示（order#comfirmで使用）

end
