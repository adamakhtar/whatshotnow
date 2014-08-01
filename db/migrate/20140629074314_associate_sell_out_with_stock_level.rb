class AssociateSellOutWithStockLevel < ActiveRecord::Migration
  def change
    add_column :sell_outs, :stock_level_id, :integer
    add_column :sell_outs, :size_id, :integer
  end
end
