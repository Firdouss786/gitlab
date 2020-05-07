class CreateIssues < ActiveRecord::Migration[5.2]
  def change
    create_table :issues do |t|
      t.integer :originator
      t.integer :assignee
      t.string :state
      t.references :fault, foreign_key: true
      t.references :aircraft, foreign_key: true
      t.text :description
      t.text :seats_impacted
      t.string :severity
      t.string :source
      t.string :callback_url

      t.timestamps
    end
    add_index :issues, :originator
    add_index :issues, :assignee
  end
end
