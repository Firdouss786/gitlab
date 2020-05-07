class DeleteUnusedTables < ActiveRecord::Migration[5.1]
  def change
    remove_foreign_key :model_revision, name: "fk_model_revision_modelrevision_stockItem_53"
    remove_foreign_key :repairprogram, name: "fk_repairprogram_repairprogram_returnstation_63"
    remove_foreign_key :repairprogram, name: "fk_repairprogram_repairprogram_station_62"
    remove_foreign_key :repairrestriction, name: "fk_repairrestriction_repairrestriction_productsubtype_64"
    remove_foreign_key :repairrestriction, name: "fk_repairrestriction_repairrestriction_stationprogram_65"
    remove_foreign_key :repairrestriction, name: "fk_repairrestriction_repairrestriction_repair_66"
    remove_foreign_key :restriction, name: "fk_restriction_restriction_mpd_68"
    remove_foreign_key :restriction, name: "fk_restriction_restriction_product_67"
    remove_foreign_key :taskapplicability, name: "fk_taskapplicability_taskapplicability_taskcardrequirement_105"
    remove_foreign_key :taskapplicability, name: "fk_taskapplicability_taskitem_taskitem_104"
    remove_foreign_key :taskitem, name: "fk_taskitem_taskitem_taskcard_89"
    remove_foreign_key :taskitem, name: "fk_taskitem_taskitem_tasksection_88"
    remove_foreign_key :tasksection, name: "fk_tasksection_tasksection_taskcard_90"
    remove_foreign_key :sw, name: "fk_sw_sw_configuration_69"
    remove_foreign_key :switem, name: "fk_switem_switem_sw_70"
    remove_foreign_key :maintenanceprogram, name: "fk_maintenanceprogram_maintenanceprogram_sw_50"
    remove_foreign_key :configurationprogram, name: "fk_configurationprogram_configurationprogram_airlineprogram_35"
    remove_foreign_key :configurationprogram, name: "fk_configurationprogram_configurationprogram_retrofitlocation"
    remove_foreign_key :configurationprogram, name: "fk_configurationprogram_configurationprogram_configuration"
    remove_foreign_key :configurationprogram_station, name: "fk_configurationprogram_station_configurationprogram_01"
    remove_foreign_key :configurationprogram_station, name: "fk_configurationprogram_station_station_02"
    remove_foreign_key :maintenanceprogram, name: "fk_maintenanceprogram_maintenanceprogram_configuration_51"
    remove_foreign_key :taskcardrequirement, name: "fk_taskcardrequirement_taskcardrequirement_maintenanceprogram"

    drop_table :configurationprogram_configuration
    drop_table :model_revision
    drop_table :patch
    drop_table :play_evolutions
    drop_table :repairprogram
    drop_table :repairrestriction
    drop_table :restriction
    drop_table :statements
    drop_table :taskapplicability
    drop_table :taskitem
    drop_table :tasksection
    drop_table :sw
    drop_table :switem
    drop_table :configurationprogram
    drop_table :configurationprogram_station
    drop_table :maintenanceprogram

  end
end
