class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|

      #FK
       t.references :genre, foreign_key: true
      #FK

      #column
      t.string  :name,        :null => false
      t.string  :image_id,    :null => false
      t.string  :description, :null => false
      t.integer :price,       :null => false
      t.boolean :is_active, default: true, null: false

      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
      #column

    end

    add_index :items, :id

  end
end
