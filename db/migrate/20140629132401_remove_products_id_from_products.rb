class RemoveProductsIdFromProducts < ActiveRecord::Migration
  def up
    remove_column :products, :product_id
  end

  def down
    # the above shoud never have existed so dont recreate it on down
  end
end
