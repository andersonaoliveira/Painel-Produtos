class AddIndexToPeriod < ActiveRecord::Migration[6.1]
  def change
    add_index :periods, :name, unique: true
    add_index :periods, :months, unique: true
  end
end
