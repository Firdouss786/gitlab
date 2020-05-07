class CreateApiAuthorizations < ActiveRecord::Migration[5.2]
  def change
    create_table :api_authorizations do |t|
      t.string :password_digest
      t.string :app_title
      t.text :reason_for_access
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
