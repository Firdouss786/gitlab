class DropApprovers < ActiveRecord::Migration[6.0]
  def change
    drop_table :approvers
  end
end
