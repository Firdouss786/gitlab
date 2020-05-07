class CreateApprovals < ActiveRecord::Migration[6.0]
  def change
    create_table :approvals do |t|
      t.boolean :approval_via_email, default: false
      t.boolean :acknowledge_after_update, default: false
      t.integer :approvable_id
      t.string  :approvable_type
      t.timestamps
    end
    add_reference :approvals, :requestee, index: true, foreign_key: { to_table: :users }
    add_index :approvals, [:approvable_type, :approvable_id], :unique => true
  end
end
