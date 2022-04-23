class AddIndexToProductGroup < ActiveRecord::Migration[6.1]
  def change
    add_index :product_groups, :name, unique: true
    add_index :product_groups, :key, unique: true
  end
end
