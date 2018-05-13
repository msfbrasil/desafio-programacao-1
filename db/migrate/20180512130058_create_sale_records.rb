class CreateSaleRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :sale_records do |t|
      t.string :purchaser_name
      t.text :item_description
      t.decimal :item_price, precision: 10, scale: 2
      t.integer :purchase_count
      t.text :merchant_address
      t.string :merchant_name

      t.timestamps
    end
  end
end
