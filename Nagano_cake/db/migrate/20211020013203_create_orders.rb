class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|

      # FK
      t.references :customer, foreign_key: true
      # FK

      # column
      t.intger  :postal_code,     :null => false
      t.string  :address,         :null => false
      t.string  :name,            :null => false
      t.integer :postage,         :null => false
      t.string  :payment,         :null => false, :default => 0 #enumを設定
      t.integer :billing_amount,  :null => false
      t.string  :status,          :null => false, :default => 0 #enumを設定

      t.timestamps
      # column

    end

    # indexを張る
    add_index :orders, :id
    # indexを張る

  end
end
