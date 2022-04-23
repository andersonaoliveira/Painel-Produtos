class RemoveProductFromPlans < ActiveRecord::Migration[6.1]
  def change
    remove_reference :plans, :product, null: false, foreign_key: true
  end
end
