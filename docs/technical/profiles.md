# Profiles
Firefly has a role based permission system. Each user is assigned a profile and each profile can have different set of permissions. Permissions are pre-defined but they can be enabled/disabled as needed via UI.

### Adding new profile
New profiles can be added via profiles page UI under settings menu or can also be added via migrations.

For migrations, it is recommended to follow [Stub Out Model](https://gist.github.com/ccschmitz/7f4df754cc8933a2033c#stub-out-models) approach to avoid any issues related to validations and callbacks. However, it is also important to remember that not all situations are same. User coding migration must access all aspects of migration. Helpful migration templates are provided at the bottom.

If a migration utilizes any method of skipping validations or callbacks then `Ability.clear_cached_permissions` must be called as first statement (in both up/down methods) to remove permissions cache.

### Initial assignment of permissions
In order to assign permissions in bulk on Firefly launch day, a rails task `rails profiles:assign_permissions` is created. This task will automatically called via migrations.

### Helpful migration templates

```ruby
class LoadProfiles < ActiveRecord::Migration[6.0]

  class Profile < ApplicationRecord
    # add any relevant validations here
  end

  def self.up
    Ability.clear_cached_permissions  # very important step

    new_profile = LoadProfiles::Profile.find_or_create_by(...)
    new_profile.permissions << Permission.first
  end

  def self.down
    Ability.clear_cached_permissions  # very important step

    profile = LoadProfiles::Profile.find_by(...)
    if profile.present?
      profile.destroy # destroy profile will also destroy all permission associations
      # or
      profile.permissions.destroy(Permission.first) # destroy specific permission(s)
    end
  end

end
```
