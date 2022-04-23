class AddServerToProduct < ActiveRecord::Migration[6.1]
  def change
    add_reference :products, :server, null: false, foreign_key: true
  end
end
