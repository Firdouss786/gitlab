class CleanUpReferences < ActiveRecord::Migration[5.1]
  def change
    rename_column :action_items, :created_by_user_id, :created_by_id
    rename_column :action_items, :assigned_to_user_id, :assigned_to_id

    rename_column :activities, :created_by_user_id, :created_by_id
    rename_column :activities, :closed_by_user_id, :closed_by_id

    rename_column :corrective_actions, :creator_id, :created_by_id

    rename_column :faults, :raised_by_user_id, :raised_by_id

    rename_column :taskcard_actions, :created_by_user_id, :created_by_id

    rename_column :taskcards, :created_by_user_id, :created_by_id

    rename_column :transfers, :sent_by_user_id, :sent_by_id
    rename_column :transfers, :received_by_user_id, :received_by_id
    rename_column :transfers, :created_by_user_id, :created_by_id
  end
end
