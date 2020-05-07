module Archivable
  extend ActiveSupport::Concern

  included do
    belongs_to :archival, optional: true

    scope :archived, -> { where.not archival: nil }
    scope :published, -> { where archival: nil }

    def archived?
      archival.present?
    end

    def published?
      archival.nil?
    end

    def archive_by(user)
      transaction do
        create_archival! user: user
        save!
      end
    end

    def archived_at
      created_at
    end

    def archived_by
      user
    end

    def restore
      transaction do
        archival.destroy
        update archival_id: nil
      end
    end

    def self.is_archivable?
      respond_to?(:archived)
    end

  end
end
