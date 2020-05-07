class CreateAccesses < ActiveRecord::Migration[6.0]
  def change
    create_table :accesses do |t|
      t.references :user, null: false, foreign_key: true
      t.string :status, default: "enabled"
      t.references :accessible, polymorphic: true, null: false

      t.timestamps
    end
  end
end
