class DropLatestCorrectiveActionIdFromFaults < ActiveRecord::Migration[6.0]
  def change
    remove_column :faults, :latest_corrective_action_id
  end
end
