class AddSlugToPeriod < ActiveRecord::Migration[6.1]
  def change
    add_column :periods, :slug, :string
    add_index :periods, :slug, unique: true
  end
end
