class AddDefaultStateToActivities < ActiveRecord::Migration[6.0]
  def change
    change_column :activities, :state, :string, default: "CREATED"
  end
end
