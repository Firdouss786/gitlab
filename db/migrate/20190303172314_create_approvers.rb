class CreateApprovers < ActiveRecord::Migration[6.0]
  def change
    create_table :approvers do |t|
      t.references :user, foreign_key: true
      t.references :approval, foreign_key: true
      t.string "state_selected", default: "pending"
    end
  end
end
