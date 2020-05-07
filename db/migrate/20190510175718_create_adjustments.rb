class CreateAdjustments < ActiveRecord::Migration[6.0]
  def change
    create_table :adjustments do |t|
      t.references :adjustable, polymorphic: true
      t.integer :quantity
      t.string :state, default: "created", index: true

      t.timestamps
    end
  end
end
