class AddFkToUsers < ActiveRecord::Migration[5.1]
  def change
    change_column :profiles, :id, :integer, auto_increment: true
    add_foreign_key :users, :profiles, index: true
  end
end
