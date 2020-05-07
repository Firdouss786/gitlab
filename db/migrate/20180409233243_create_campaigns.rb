class CreateCampaigns < ActiveRecord::Migration[5.2]
  def change
    create_table :campaigns do |t|
      t.references :task_template, foreign_key: true
      t.string :state
      t.datetime :scheduled_start
      t.datetime :scheduled_end

      t.timestamps
    end
  end
end
