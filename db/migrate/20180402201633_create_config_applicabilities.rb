class CreateConfigApplicabilities < ActiveRecord::Migration[5.2]
  def change
    create_table :config_applicabilities do |t|
      t.string :applicable_content
      t.string :applicable_software
      t.references :fleet, foreign_key: true
      t.references :task_template, foreign_key: true

      t.timestamps
    end
  end
end
