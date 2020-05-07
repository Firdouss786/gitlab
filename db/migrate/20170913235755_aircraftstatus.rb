class Aircraftstatus < ActiveRecord::Migration[5.1]
  def change
    remove_foreign_key :aircraftstatus, name: "fk_aircraftstatus_aircraftstatus_activity_16"
    remove_foreign_key :aircraftstatus, name: "fk_aircraftstatus_aircraftstatus_aircraft_15"
    remove_foreign_key :aircraftstatus, name: "fk_aircraftstatus_aircraftstatus_arrivalairport_18"
    remove_foreign_key :aircraftstatus, name: "fk_aircraftstatus_aircraftstatus_departureairport_19"
    remove_foreign_key :aircraftstatus, name: "fk_aircraftstatus_lastron_airport_id_103"
    remove_foreign_key :aircraftstatus, name: "fk_aircraftstatus_nextron_airport_id_102"
    remove_foreign_key :aircraftstatus, name: "fk_aircraftstatus_aircraftstatus_ronnothales_110"
    remove_foreign_key :aircraftstatus, name: "fk_aircraftstatus_aircraftstatus_contentactivationstation_107"
    remove_foreign_key :aircraftstatus, name: "fk_aircraftstatus_aircraftstatus_contentloadstation_108"
    remove_foreign_key :aircraftstatus, name: "fk_aircraftstatus_aircraftstatus_softwareloadstation_109"

    drop_table :aircraftstatus
  end
end