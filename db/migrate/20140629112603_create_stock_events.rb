class CreateStockEvents < ActiveRecord::Migration
  def change
    create_table :stock_events do |t|
      t.string :name
      t.integer :stock_level_id
      t.timestamps
    end

    add_index :stock_events, :name
    add_index :stock_events, :stock_level_id
  end
end
