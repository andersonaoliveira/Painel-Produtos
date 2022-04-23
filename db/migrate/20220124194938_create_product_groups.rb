class CreateProductGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :product_groups do |t|
      t.string :name
      t.string :description
      t.string :icon
      t.string :key

      t.timestamps
    end
  end
end
