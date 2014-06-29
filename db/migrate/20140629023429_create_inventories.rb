class CreateInventories < ActiveRecord::Migration
  def change
    create_table :inventories do |t|
      t.string :size
      t.string :status
      t.datetime :seen_at
      t.integer  :product_id

      t.timestamps
    end

    add_index(:inventories, :product_id)
  end
end
