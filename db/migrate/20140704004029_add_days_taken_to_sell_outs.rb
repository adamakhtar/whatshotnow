class AddDaysTakenToSellOuts < ActiveRecord::Migration
  def up
    add_column :sell_outs, :days_taken, :integer
    remove_column :sell_outs, :speed
  end

  def down
    remove_column :sell_outs, :days_taken
    add_column :sell_outs, :speed, :string
  end
end
