class RemoveProductFromServer < ActiveRecord::Migration[6.1]
  def change
    remove_reference :servers, :product, null: false, foreign_key: true
  end
end
