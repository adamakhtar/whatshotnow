class AddCentsToPrices < ActiveRecord::Migration
  def change
    rename_column :prices, :price, :price_cents
  end
end
