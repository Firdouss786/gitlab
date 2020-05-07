class CreateCompletions < ActiveRecord::Migration[5.2]
  def change
    create_table :completions do |t|
      t.references :user, foreign_key: true

      t.integer :completable_id
      t.string  :completable_type

      t.timestamps
    end

    add_index :completions, [:completable_type, :completable_id]
  end
end
