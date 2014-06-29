class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :product_id
      t.string :image

      t.timestamps
    end
  end
end
