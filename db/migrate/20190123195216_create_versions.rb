class CreateVersions < ActiveRecord::Migration[5.2]
  def change
    create_table :versions do |t|
      t.float :version, default: 0

      t.timestamps
    end
  end
end
