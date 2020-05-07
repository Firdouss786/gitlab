class UserCleanup < ActiveRecord::Migration[5.1]
  def change
    # Rename
    rename_column :user, :user_id, :id

    # Add some columns from authuser
    add_column :user, :email, :string
    add_column :user, :secondary_email, :string
    add_column :user, :profile_id, :integer
    add_column :user, :legacy_password, :string

    rename_column :user, :user_location_airport_id, :airport_id
    rename_column :user, :user_firstname, :first_name
    rename_column :user, :user_lastname, :last_name
    rename_column :user, :user_jobtitle, :job_title
    rename_column :user, :user_manager_user_id, :manager_user_id
    rename_column :user, :user_locked, :locked
    rename_column :user, :user_active, :active
    rename_column :user, :user_airline_airline_id, :default_airline_id

    execute <<-SQL
      UPDATE user
      JOIN authuser
      ON authuser.authuser_id = user.user_authuser_authuser_id
      SET user.locked = authuser.authuser_locked,
      user.email = authuser.authuser_email,
      user.secondary_email = authuser.authuser_verificationcodeemail,
      user.profile_id = authuser.authuser_profile_authprofile_id,
      user.legacy_password = authuser.authuser_password
    SQL

    # Remove
    remove_column :user, :user_uiversion

    remove_column :user, :user_picture
    remove_column :user, :user_connections

    remove_foreign_key :user, name: "fk_user_user_authuser_97"
    remove_column :user, :user_authuser_authuser_id

    # Timestamps
    model_name = "user"

    timestamp_name = model_name + "_timestamp"
    add_column model_name.to_sym, :created_at, :datetime
    add_column model_name.to_sym, :updated_at, :datetime
    execute "UPDATE #{model_name} SET created_at = #{timestamp_name}"
    execute "UPDATE #{model_name} SET updated_at = #{timestamp_name}"
    remove_column model_name.to_sym, timestamp_name.to_sym, :updated_at

    # Tablename
    rename_table :user, :users
  end
end
