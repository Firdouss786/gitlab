class Version < ApplicationRecord

  def self.track_version_change
    initialize_version || track_new_version
  end

  private
    def self.initialize_version
      Version.create(version: Firefly::VERSION) unless db_version
    end

    def self.track_new_version
      if version_has_changed?
        save_new_version
        notify_of_version_upgrade
      end
    end

    def self.db_version
      Version.last
    end

    def self.app_version
      Firefly::VERSION.to_f
    end

    def self.version_has_changed?
      Firefly::VERSION.to_f > Version.last.version
    end

    def self.save_new_version
      db_version.tap do |v|
        v.version = app_version
        v.save!
      end
    end

    def self.notify_of_version_upgrade
      AdminMailer.version_change(new_version: db_version.version.to_s).deliver_later
    end

end
