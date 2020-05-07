class CreateProgramsStations < ActiveRecord::Migration[5.2]
  def change
    create_table :programs_stations do |t|
      t.references :program, foreign_key: true
      t.references :station, foreign_key: true

      t.timestamps
    end
  end
end
