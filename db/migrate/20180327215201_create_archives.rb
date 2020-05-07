class CreateArchives < ActiveRecord::Migration[5.2]
  def change
    create_table :archives do |t|
      t.references :user, foreign_key: true

      t.integer :archivable_id
      t.string  :archivable_type

      t.timestamps
    end

    add_index :archives, [:archivable_type, :archivable_id]
  end
end
