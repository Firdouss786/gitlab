class CreatePermission < ActiveRecord::Migration[6.0]

  def change

    create_table :permissions do |t|
      t.string :name
      t.text :description
      t.string :subject_class
      t.string :action
      t.integer :subject_id
      t.timestamps
    end

    create_table :permissions_profiles do |t|
      t.belongs_to :profile
      t.belongs_to :permission
      t.timestamps
    end

  end

end
