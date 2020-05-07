class Access < ApplicationRecord
  include Approvable

  belongs_to :user
  belongs_to :accessible, polymorphic: true

  validates :user, uniqueness: { scope: :accessible }

  enum status: { enabled: 'enabled', disabled: 'disabled' }

  after_create do
    request_approval_unless_admin
  end

  def approve!
    enabled!
    notify_approvers_of_approved_access
    notify_requestee_of_approved_access
  end

  def approvable_resource_name
    accessible.accessible_resource_name
  end

  def approvable_approvers
    accessible.accessible_approvers
  end

  private
    def request_approval_unless_admin
      if Current.user
        unless Current.user.try(:admin?)
          # Disabled this feature as it needs more thorough QA testing - Chris Dec 17 2019
          # disabled!
          # Approval.create approvable: self, requestee: user, users: approvable_approvers
        end
      end
    end

    def notify_approvers_of_approved_access
      AccessMailer.notify_approvers_of_approved_access(self).deliver_later
    end

    def notify_requestee_of_approved_access
      AccessMailer.notify_requestee_of_approved_access(self).deliver_later
    end
end
