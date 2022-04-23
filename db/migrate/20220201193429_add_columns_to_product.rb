class AddColumnsToProduct < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :customer, :string
    add_reference :products, :plan, null: false, foreign_key: true
    add_column :products, :server_code, :string
  end
end
