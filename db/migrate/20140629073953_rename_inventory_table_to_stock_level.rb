class RenameInventoryTableToStockLevel < ActiveRecord::Migration
  def change
    rename_table :inventories, :stock_levels
  end
end
