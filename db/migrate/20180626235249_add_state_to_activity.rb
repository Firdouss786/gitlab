class AddStateToActivity < ActiveRecord::Migration[5.2]
  def change
    add_column :activities, :state, :string
  end
end
