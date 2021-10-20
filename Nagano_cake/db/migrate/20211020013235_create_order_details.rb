class CreateOrderDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :order_details do |t|

      # FK
      t.references :order, foreign_key: true
      t.references :item,  foreign_key: true
      # FK

      # column
      t.string  :making_status,  :null => false, :default => 0 #enum
      t.integer :price_on_order, :null => false
      t.integer :item_quantity,  :null => false

      t.timestamps
      # column

    end

    # indexを張る
    add_index :orders, :id
    # indexを張る

  end
end
