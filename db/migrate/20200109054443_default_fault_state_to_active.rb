class DefaultFaultStateToActive < ActiveRecord::Migration[6.0]
  def change
    change_column :faults, :state, :string, default: "ACTIVE"
  end
end
