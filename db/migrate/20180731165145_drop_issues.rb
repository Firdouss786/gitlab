class DropIssues < ActiveRecord::Migration[5.2]
  def change
    drop_table :issues
  end
end
