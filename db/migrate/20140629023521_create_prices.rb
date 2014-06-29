class CreatePrices < ActiveRecord::Migration
  def change
    create_table :prices do |t|
      t.integer :product_id
      t.integer :price
      t.string :currency
      t.datetime :seen_at

      t.timestamps
    end

    add_index(:prices, :product_id)
  end
end
