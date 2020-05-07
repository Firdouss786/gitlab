class UserEditPermission < ActiveRecord::Migration[6.0]

  def self.up
    Ability.clear_cached_permissions

    new_permission = { name: 'Users Management (Edit only)', description: 'Can edit users and update their profiles', subject_class: 'user', action: 'update', subject_id: '' }

    permission = Permission.find_by_name(new_permission[:name])
    if permission.present?
      Permission.update(permission.id, new_permission)
    else
      Permission.create(new_permission)
    end
  end

  def self.down
    Permission.find_by_name('Users Management (Edit only)').try(:destroy)
    Ability.clear_cached_permissions
  end

end
