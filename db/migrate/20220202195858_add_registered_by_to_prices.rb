class AddRegisteredByToPrices < ActiveRecord::Migration[6.1]
  def change
    add_column :prices, :registered_by, :string
  end
end
