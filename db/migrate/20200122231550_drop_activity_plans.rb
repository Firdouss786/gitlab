class DropActivityPlans < ActiveRecord::Migration[6.0]
  def change
    drop_table :activity_plans
  end
end
