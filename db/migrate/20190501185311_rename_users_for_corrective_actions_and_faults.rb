class RenameUsersForCorrectiveActionsAndFaults < ActiveRecord::Migration[6.0]
  def change
    rename_column :faults, :user_id, :recorded_by_id
    rename_column :faults, :raised_by_id, :user_id

    rename_column :corrective_actions, :user_id, :performed_by_id
    rename_column :corrective_actions, :created_by_id, :user_id
  end
end
