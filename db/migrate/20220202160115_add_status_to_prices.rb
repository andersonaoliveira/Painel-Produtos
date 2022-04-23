class AddStatusToPrices < ActiveRecord::Migration[6.1]
  def change
    add_column :prices, :status, :integer, default: 0
  end
end
