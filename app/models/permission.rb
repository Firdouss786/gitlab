class Permission < ApplicationRecord

  after_update :clear_related_cache

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  has_many :permissions_profiles, dependent: :destroy
  has_many :profiles, through: :permissions_profiles

  private

    def clear_related_cache
      self.profiles.ids.each { |p| Rails.cache.delete("profile:#{p}:permissions") }
    end

end
