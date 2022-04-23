class RemoveColumnsFromProduct < ActiveRecord::Migration[6.1]
  def change
    remove_column :products, :name, :string
    remove_column :products, :description, :string
    remove_column :products, :code, :string
  end
end
