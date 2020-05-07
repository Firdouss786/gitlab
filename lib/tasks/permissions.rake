namespace :permissions do

  desc "Load permissions dataset"
  task load: :environment do

    permissions = [
      { name: 'Admin Access', description: 'Administrator acceess for site admins', subject_class: 'all', action: 'manage', subject_id: '' },
      { name: 'Activities Management', description: 'Can manage activities and nested actions', subject_class: 'activity, sign_off, task, task_action, fault, fault_resolution, corrective_action, deferral_action', action: 'manage', subject_id: '' }
    ]

    validated_permissions = []

    permissions.each do |p|
      permission = Permission.new(p)
      abort ("Permission: #{permission.inspect}" + "\n" +"Errors: #{permission.errors.inspect}") unless permission.valid?
      validated_permissions << permission
    end

    validated_permissions.each(&:save)
  end

end
