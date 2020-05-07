class Comment < ApplicationRecord
  belongs_to :user, default: -> { Current.user }
  belongs_to :commentable, polymorphic: true

  scope :asc, -> { order(created_at: :asc) }
  scope :desc, -> { order(created_at: :desc) }

  validates :description, presence: true
end
