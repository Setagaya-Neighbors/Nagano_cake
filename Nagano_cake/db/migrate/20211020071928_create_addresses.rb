class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|

    #FK
       t.references :customer, foreign_key: true
    #FK

    #追記カラム
      t.string  :name,         null: false
      t.string  :postal_code,  null: false
      t.string  :address,      null: false
    #追記カラム
      t.datetime :created_at
      t.datetime :update_at
    #ここまで
      t.timestamps
    end
  end
end
