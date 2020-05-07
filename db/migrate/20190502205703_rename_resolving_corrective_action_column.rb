class RenameResolvingCorrectiveActionColumn < ActiveRecord::Migration[6.0]
  def change
    rename_column :faults, :corrective_action_id, :resolving_corrective_action_id
  end
end
