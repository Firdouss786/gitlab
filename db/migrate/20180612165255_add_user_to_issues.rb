class AddUserToIssues < ActiveRecord::Migration[5.2]
  def change
    add_reference :issues, :user, foreign_key: true
    remove_column :issues, :originator
  end
end
