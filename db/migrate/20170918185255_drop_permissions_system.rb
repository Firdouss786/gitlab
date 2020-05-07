class DropPermissionsSystem < ActiveRecord::Migration[5.1]
  def change
    remove_foreign_key :authprofile_authpermission, name: "fk_authprofile_authpermission_authpermission_02"
    remove_foreign_key :authprofile_authpermission, name: "fk_authprofile_authpermission_authprofile_01"

    remove_foreign_key :authprofile_authrole, name: "fk_authprofile_authrole_authprofile_01"
    remove_foreign_key :authprofile_authrole, name: "fk_authprofile_authrole_authrole_02"

    remove_foreign_key :authuser, name: "fk_authuser_authuser_profile_25"

    remove_foreign_key :authuser_authpermission, name: "fk_authuser_authpermission_authpermission_02"
    remove_foreign_key :authuser_authpermission, name: "fk_authuser_authpermission_authuser_01"

    drop_table :authpermission
    drop_table :authprofile_authpermission
    drop_table :authprofile_authrole
    drop_table :authrole
    drop_table :authuser
    drop_table :authuser_authpermission
  end
end
