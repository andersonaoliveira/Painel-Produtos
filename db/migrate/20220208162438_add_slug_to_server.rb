class AddSlugToServer < ActiveRecord::Migration[6.1]
  def change
    add_column :servers, :slug, :string
    add_index :servers, :slug, unique: true
  end
end
