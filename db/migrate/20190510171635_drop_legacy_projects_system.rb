class DropLegacyProjectsSystem < ActiveRecord::Migration[6.0]
  def change
    drop_table :events
    drop_table :action_items
    drop_table :projects
  end
end
