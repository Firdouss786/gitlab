class Approval < ApplicationRecord
  belongs_to :approvable, polymorphic: true, dependent: :destroy

  belongs_to :requestee, class_name: "User"
  has_and_belongs_to_many :users, -> { unlocked }

  validates :status, presence: true
  enum status: { pending: 'pending', approved: 'approved' }

  after_update if: :approved? do
    approvable.approve!
  end
end
