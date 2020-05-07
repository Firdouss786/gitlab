class CreateSeats < ActiveRecord::Migration[5.2]
  def change
    create_table :seats do |t|
      t.string :name
      t.string :col
      t.integer :row
      t.string :travel_class
      t.integer :deck
      t.integer :dsu_primary
      t.integer :dsu_secondary
      t.references :fleet, foreign_key: true

      t.timestamps
    end
  end
end
