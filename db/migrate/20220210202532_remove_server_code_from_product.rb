class RemoveServerCodeFromProduct < ActiveRecord::Migration[6.1]
  def change
    remove_column :products, :server_code, :string
  end
end
