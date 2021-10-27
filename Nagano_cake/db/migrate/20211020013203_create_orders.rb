class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|

      # FK
      t.references :customer, foreign_key: true
      # FK

      # column
      t.integer :postal_code,     :null => false
      t.string  :address,         :null => false
      t.string  :name,            :null => false
      t.integer :postage,         :null => false
      t.integer :payment,         :null => false, :default => 0 #enumを設定
      t.integer :billing_amount,  :null => false
      t.integer :status,          :null => false, :default => 0 #enumを設定

      t.timestamps
      # column

    end
  end
end
