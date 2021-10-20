class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|

      #FK
       t.reference :genre, foreign_ket: true
      #FK

      #追記カラム
      t.string :name          ,:null => false
      t.string :image_id　    ,:null => false
      t.string :description   ,:null => false
      t.integer :price        ,:null => false

      add_column :is_active, :boolean, default: false, null: false

      t.datetime :created_at
      t.datetime :updated_at
      #ここまで

      t.timestamps

      add_index :items, :id

    end
  end
end
