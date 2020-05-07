class Activityplan < ActiveRecord::Migration[5.1]
  def change
    remove_foreign_key :activityplan, name: "fk_activityplan_activity_realactivity_9"
    remove_foreign_key :activityplan, name: "fk_activityplan_activity_aircraft_8"
    remove_foreign_key :activityplan, name: "fk_activityplan_activity_inboundairport_7"
    remove_foreign_key :activityplan, name: "fk_activityplan_activity_location_6"
    remove_foreign_key :activityplan_taskcard, name: "fk_activityplan_taskcard_activityplan_01"
    remove_foreign_key :activityplan_taskcard, name: "fk_activityplan_taskcard_taskcard_02"
    remove_foreign_key :aircraftstatus, name: "fk_aircraftstatus_aircraftstatus_activityplan_17"

    drop_table :activityplan
    drop_table :activityplan_taskcard
  end
end
