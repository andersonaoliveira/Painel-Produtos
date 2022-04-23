class AddSlugToProductGroup < ActiveRecord::Migration[6.1]
  def change
    add_column :product_groups, :slug, :string
    add_index :product_groups, :slug, unique: true
  end
end
