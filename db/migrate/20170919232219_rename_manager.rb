class RenameManager < ActiveRecord::Migration[5.1]
  def change
    rename_column :users, :manager_user_id, :manager_id
  end
end
