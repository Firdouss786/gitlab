class LoadPermissionsWithAssociations < ActiveRecord::Migration[6.0]

  def self.up
    Rake::Task['permissions:load'].invoke
    Rake::Task['profiles:assign_permissions'].invoke
  end

  def self.down
  end

end
