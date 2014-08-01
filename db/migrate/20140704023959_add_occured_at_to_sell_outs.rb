class AddOccuredAtToSellOuts < ActiveRecord::Migration
  def change
    add_column :sell_outs, :occurred_at, :datetime
  end
end
