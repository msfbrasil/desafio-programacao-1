class ChangeColumnName < ActiveRecord::Migration[5.0]
  def change
    rename_column :sale_records, :purchase_name, :purchaser_name
  end
end
