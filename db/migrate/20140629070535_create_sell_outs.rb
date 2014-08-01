class CreateSellOuts < ActiveRecord::Migration
  def change
    create_table :sell_outs do |t|
      t.string :speed
      t.integer :product_id

      t.timestamps
    end
  end
end
