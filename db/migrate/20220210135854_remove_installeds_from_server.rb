class RemoveInstalledsFromServer < ActiveRecord::Migration[6.1]
  def change
    remove_column :servers, :installed, :string
  end
end
