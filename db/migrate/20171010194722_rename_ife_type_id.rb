class RenameIfeTypeId < ActiveRecord::Migration[5.1]
  def change
    rename_column :fleets, :ife_type_id, :software_platform_id
  end
end
