class RemoveAdministratorFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :administrator, :boolean
  end
end
