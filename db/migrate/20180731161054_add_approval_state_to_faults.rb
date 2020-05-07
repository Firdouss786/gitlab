class AddApprovalStateToFaults < ActiveRecord::Migration[5.2]
  def change
    add_column :faults, :approval_state, :string
  end
end
