class Ability
  include CanCan::Ability

  def initialize(user)
    can :manage, :session
    can :manage, :password_reset

    if user.present?
      can :read, :all

      permissions = Rails.cache.fetch("profile:#{user.profile_id}:permissions") { user.profile.permissions.to_a }

      permissions.each do |permission|
        actions = permission['action'].split(",").map(&:strip).map(&:to_sym)
        klasses = permission['subject_class'].split(",").map(&:strip).map(&:to_sym)
        can actions, klasses
      end
    end
  end

  def self.clear_cached_permissions
    Profile.ids.each { |p| Rails.cache.delete("profile:#{p}:permissions") }
  end

end
