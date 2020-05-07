# Permissions
Firefly is utilizing [cancancan](https://github.com/CanCanCommunity/cancancan) gem to manage user permissions.

**Recommended:** Any programmer working on profiles or permissions must get familiarize with Cancancan using their [wiki](https://github.com/CanCanCommunity/cancancan/wiki).

### Defining abilities
Permissions (abilities) which are essential for every user are defined (hardcoded) in `/models/ability.rb` file. All other custom abilities are saved in database to allow global access and easy assignment.

Development and Test environment use fixtures to load permissions dataset.

For Production, a rails task `rails permissions:load` is created to load permissions in bulk on Firefly launch day. This task will run automatically via migration.

##### Abilities follow two different types of formatting:

Permissions that rely on specific model attributes:\
`can :manage, Fault, id: [any_ids]`

Permissions that are controller based:\
`can :manage, :fault`

Besides adding the permissions, it is also **required** to add the following into your controller:

For permissions that are specific to model and its attributes:\
`authorize_resource` # goes after all before_action calls as this requires access to instance variable

For permissions that are controller based:\
`authorize_resource class: false` # goes above all before_action

It is also possible to skip `authorize_resource {}` call and add `authorize!` directly inside any action. This gives the advantage of checking permission on any model. i.e.

```ruby
def update
  authorize! :update, @user
  ...
end
```

### Adding new permissions (abilities)

New permissions can be only be generated via migrations.

It is recommended to follow [Stub Out Model](https://gist.github.com/ccschmitz/7f4df754cc8933a2033c#stub-out-models) approach to avoid any issues related to validations and callbacks. However, it is also important to remember that not all situations are same. User coding migration must access all aspects of migration. Helpful migration templates are provided at the bottom.

If a migration utilizes any method of skipping validations or callbacks then `Ability.clear_cached_permissions` must be called as first statement (in both up/down methods) to remove permissions cache.

Cancancan abilities can easily be translated to Permission hash as follows:

To give admin full access:\
`can :manage, :all` -> `{ name: 'Admin Access', description: 'Administrator access for site admins', subject_class: 'all', action: 'manage', subject_id: '' }`


To give user full permission on every action on posts_controller:\
`can :manage, Post` -> `{ name: 'Full Posts Access', description: 'All permissions related to Posts model', subject_class: 'post', action: 'manage', subject_id: '' }`

To give user read only permission on posts_controller:\
`can :read, Post` -> `{ name: 'Posts Read Access', description: 'Read only access to Posts model', subject_class: 'post', action: 'read', subject_id: '' }`

To give user create and edit permissions on posts_controller:\
`can [:read, :create, :update], Post` -> `{ name: 'Posts Write Access', description: 'Read, create and update access to Posts model', subject_class: 'post', action: 'read, create, update', subject_id: '' }`


### Helpful migration template

```ruby
class LoadPermissions < ActiveRecord::Migration[6.0]

  class Permission < ApplicationRecord
    # add any relevant validations here
  end

  permissions = [
    { name: 'Admin Access', description: 'Administrator acceess for site admins', subject_class: 'all', action: 'manage', subject_id: '' },
    { name: 'Activities Management', description: 'Can manage activities and nested actions', subject_class: 'activity, sign_off, task, task_action, fault, fault_resolution, corrective_action, deferral', action: 'manage', subject_id: '' }
  ]

  def self.up
    Ability.clear_cached_permissions  # very important step

    permissions.each |p| do
      permission = LoadPermissions::Permission.find_by_name(p[:name])
        if permission.present?
          LoadPermissions::Permission.update(permission.id, p)
        else
          LoadPermissions::Permission.create(p)
        end
    end

    # optional - delete a specific permission
    LoadPermissions::Permission.where(name: 'Admin Access').destroy

    # optional - delete all other permissions not in provided hash
    LoadPermissions::Permission.where.not(name: permissions.map { |p| p[:name] }).destroy_all

  end

  def self.down
    Ability.clear_cached_permissions  # very important step

    # any other action that is reversible
  end

end
```
