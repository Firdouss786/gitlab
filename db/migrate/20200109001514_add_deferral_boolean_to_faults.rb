class AddDeferralBooleanToFaults < ActiveRecord::Migration[6.0]
  def change
    add_column :faults, :deferral, :boolean, default: false
  end
end
