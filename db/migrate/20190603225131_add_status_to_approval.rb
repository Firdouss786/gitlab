class AddStatusToApproval < ActiveRecord::Migration[6.0]
  def change
    add_column :approvals, :status, :string, default: "pending"
    add_index :approvals, :status
  end
end
