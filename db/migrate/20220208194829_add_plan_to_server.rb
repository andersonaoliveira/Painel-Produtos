class AddPlanToServer < ActiveRecord::Migration[6.1]
  def change
    add_reference :servers, :plan, null: false, foreign_key: true, default: 0
  end
end
