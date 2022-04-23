class CreatePlans < ActiveRecord::Migration[6.1]
  def change
    create_table :plans do |t|
      t.string :name
      t.string :description
      t.string :details
      t.references :product, null: false, foreign_key: true
      t.string :code
      t.integer :status, default:0

      t.timestamps
    end
  end
end
