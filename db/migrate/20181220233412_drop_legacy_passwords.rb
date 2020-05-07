class DropLegacyPasswords < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :legacy_password
  end
end
