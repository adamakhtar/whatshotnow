class AddHotnessScoreToProducts < ActiveRecord::Migration
  def change
    add_column :products, :hotness_score, :float, default: 0.0
  end
end
