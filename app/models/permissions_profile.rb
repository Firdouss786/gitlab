class PermissionsProfile < ApplicationRecord

  after_commit :clear_cache_entry

  belongs_to :profile
  belongs_to :permission

  private

    def clear_cache_entry
      Rails.cache.delete("profile:#{self.profile_id}:permissions")
    end

end
