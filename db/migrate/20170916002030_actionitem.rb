class Actionitem < ActiveRecord::Migration[5.1]
  def change
    # Rename
    rename_column :actionitem, :actionitem_id, :id

    rename_column :actionitem, :actionitem_project_project_id, :project_id
    rename_column :actionitem, :actionitem_status, :state
    rename_column :actionitem, :actionitem_creator_user_id, :created_by_user_id
    rename_column :actionitem, :actionitem_owner_user_id, :assigned_to_user_id
    rename_column :actionitem, :actionitem_targetdate, :target_date
    rename_column :actionitem, :actionitem_startdate, :started_at
    rename_column :actionitem, :actionitem_stopdate, :completed_at
    rename_column :actionitem, :actionitem_description, :description
    rename_column :actionitem, :actionitem_name, :name

    # Timestamps
    model_name = "actionitem"

    timestamp_name = model_name + "_timestamp"
    add_column model_name.to_sym, :created_at, :datetime
    add_column model_name.to_sym, :updated_at, :datetime
    execute "UPDATE #{model_name} SET created_at = #{timestamp_name}"
    execute "UPDATE #{model_name} SET updated_at = #{timestamp_name}"
    remove_column model_name.to_sym, timestamp_name.to_sym, :updated_at

    # Tablename
    rename_table :actionitem, :action_items
  end
end
