class RemoveInstalledFromServer < ActiveRecord::Migration[6.1]
  def change
    remove_column :servers, :installed, :integer
  end
end
