class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.references :eventable, polymorphic: true
      t.references :stock_item, foreign_key: true

      t.timestamps
    end
  end
end
