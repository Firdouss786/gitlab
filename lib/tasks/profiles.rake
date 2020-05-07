
namespace :profiles do

  desc "Associate profiles to permissions"
  task assign_permissions: :environment do

    Profile.all.each do |profile|
      case profile.name
      when "GFA-ONLY MAINTENANCE OVERVIEW"
      when "THALES ENGINEERING"
      when "Thales Program Managment"
      when "THALES SERVO ADMIN"
        permissions = get_permissions 'Admin Access'
        assign_permission(profile, permissions)
      when "THALES AOC PLANNING"
      when "THALES LINE SUPERVISOR"
      when "THALES MCC MANAGER"
      when "STATION DIRECTOR"
      when "THALES MAINTENANCE RELIABILITY"
      when "THALES AOC / MCC MANAGER"
      when "CLIENT PORTAL PROFILE"
      when "CUSTOMER MAINTENANCE OVERVIEW"
      when "THALES LINE LOGISTICS"
      when "THALES LOGISTICS MANAGER"
      when "FIELD SERVICE ENGINEER"
      when "THALES LINE TECH"
        permissions = get_permissions 'Activities Management'
        assign_permission(profile, permissions)
      when "THALES AOC / MCC OPS"
      when "THALES LINE MCC"
      when "THALES LINE MANAGER"
      end
    end

  end
end

private

  def get_permissions(names)
    names.split(', ').map { |name| Permission.find_by_name(name) }.compact
  end

  def assign_permission(profile, permissions)
    permissions.each do |p|
      time = Time.now.to_s(:db)
      ActiveRecord::Base.connection.execute "INSERT INTO permissions_profiles (profile_id, permission_id, created_at, updated_at) VALUES ('#{profile.id}', '#{p.id}', '#{time}', '#{time}');"
    end
  end
