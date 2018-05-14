class CreateSaleRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :sale_records do |t|
      t.string :purchaser_name, null: false
      t.text :item_description, null: false
      t.decimal :item_price, precision: 10, scale: 2, null: false
      t.integer :purchase_count, null: false
      t.text :merchant_address, null:false
      t.string :merchant_name, null:false

      t.timestamps
    end
  end
end
