class AddSizeIdToStockLevels < ActiveRecord::Migration
  def change
    add_column :stock_levels, :size_id, :integer
  end
end
