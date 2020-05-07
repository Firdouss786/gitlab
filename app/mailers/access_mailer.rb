class AccessMailer < ApplicationMailer
  default from: Firefly::SUPPORT_EMAIL

  def notify_requestee_of_approved_access(access)
    @access = access
    mail to: access.approval.requestee.email, subject: "You have been approved access to #{@access.approvable_resource_name}"
  end

  def notify_approvers_of_approved_access(access)
    @access = access
    mail to: access.approval.users.pluck(:email).join(", "), subject: "#{@access.approval.requestee.full_name} has been approved access to #{@access.approvable_resource_name}"
  end
end
