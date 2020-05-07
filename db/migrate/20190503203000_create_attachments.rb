class CreateAttachments < ActiveRecord::Migration[6.0]
  def change
    create_table :attachments do |t|
      t.references :fault, foreign_key: true
      t.boolean :cid
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
