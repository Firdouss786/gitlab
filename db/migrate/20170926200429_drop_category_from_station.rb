class DropCategoryFromStation < ActiveRecord::Migration[5.1]
  def change
    remove_column :stations, :category
  end
end
