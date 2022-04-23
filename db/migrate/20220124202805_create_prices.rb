class CreatePrices < ActiveRecord::Migration[6.1]
  def change
    create_table :prices do |t|
      t.references :period, null: false, foreign_key: true
      t.references :plan, null: false, foreign_key: true
      t.decimal :value, :precision => 8, :scale => 2


      t.timestamps
    end
  end
end
