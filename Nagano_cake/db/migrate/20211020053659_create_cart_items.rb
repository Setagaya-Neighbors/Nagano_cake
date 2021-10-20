class CreateCartItems < ActiveRecord::Migration[5.2]
  def change
    create_table :cart_items do |t|

      # FK
      t.references :customer, foreign_key: true
      t.references :item,     foreign_key: true
      # FK

      # column
      t.integer :quantity, :null => false

      t.timestamps
      # column
    end

    # indexを張る
    add_index :cart_items, :id
    # indexを張る

  end
end
