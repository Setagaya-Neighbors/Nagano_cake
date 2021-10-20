class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|

      #追記カラム
      t.string :name
      t.string :image_id
      t.string :description
      t.integer :price
      t.boolean :is_active
      t.datetime :created_at
      t.datetime :updated_at
      #ここまで

      t.timestamps
    end
  end
end
