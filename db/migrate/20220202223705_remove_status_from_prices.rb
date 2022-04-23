class RemoveStatusFromPrices < ActiveRecord::Migration[6.1]
  def change
    remove_column :prices, :status, :string
  end
end
