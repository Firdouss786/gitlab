class CreateConfigFiles < ActiveRecord::Migration[5.2]
  def change
    create_table :config_files do |t|
      t.references :fleet, foreign_key: true
      t.string :file_type
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
