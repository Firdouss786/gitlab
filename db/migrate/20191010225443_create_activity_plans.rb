class CreateActivityPlans < ActiveRecord::Migration[6.0]
  def change
    create_table :activity_plans do |t|
      t.references :station, null: false, foreign_key: true
      t.references :aircraft, null: false, foreign_key: true
      t.references :flight, null: true, foreign_key: true
      t.references :activity, null: true, foreign_key: true
      t.datetime :original_arrival_time
      t.string :state

      t.timestamps
    end
  end
end
