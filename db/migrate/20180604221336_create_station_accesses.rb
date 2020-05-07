class CreateStationAccesses < ActiveRecord::Migration[5.2]
  def change
    create_table :station_accesses do |t|
      t.references :user, foreign_key: true
      t.references :station, foreign_key: true

      t.timestamps
    end
  end
end
