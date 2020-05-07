class RestructureFlightTimeColumns < ActiveRecord::Migration[5.2]
  def change
    remove_column :flights, :out_scheduled_at
    remove_column :flights, :out_actual_at
    remove_column :flights, :off_actual_at
    remove_column :flights, :in_scheduled_at
    remove_column :flights, :in_actual_at
    remove_column :flights, :on_actual_at

    add_column :flights, :filed_departure_time, :datetime
    add_column :flights, :actual_departure_time, :datetime
    add_column :flights, :filed_blockout_time, :datetime
    add_column :flights, :estimated_blockout_time, :datetime
    add_column :flights, :actual_blockout_time, :datetime
    add_column :flights, :filed_arrival_time, :datetime
    add_column :flights, :estimated_arrival_time, :datetime
    add_column :flights, :actual_arrival_time, :datetime
    add_column :flights, :filed_blockin_time, :datetime
    add_column :flights, :estimated_blockin_time, :datetime
    add_column :flights, :actual_blockin_time, :datetime
  end
end
