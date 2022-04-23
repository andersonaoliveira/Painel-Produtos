class AddProductCodeToProduct < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :product_code, :string
  end
end
