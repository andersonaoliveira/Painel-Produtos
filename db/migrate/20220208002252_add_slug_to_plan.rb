class AddSlugToPlan < ActiveRecord::Migration[6.1]
  def change
    add_column :plans, :slug, :string
    add_index :plans, :slug, unique: true
  end
end
