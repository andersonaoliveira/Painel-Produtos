class CreateServers < ActiveRecord::Migration[6.1]
  def change
    create_table :servers do |t|
      t.integer :capacity
      t.string :code
      t.integer :installed
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
