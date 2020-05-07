class Bom < ActiveRecord::Migration[5.1]
  def change
    drop_table :bom
  end
end
