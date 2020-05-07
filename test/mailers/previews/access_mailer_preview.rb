# Preview all emails at http://localhost:3000/rails/mailers/access_mailer
class AccessMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/access_mailer/notify_requestee_of_approved_access
  def notify_requestee_of_approved_access
    AccessMailer.notify_requestee_of_approved_access
  end

  # Preview this email at http://localhost:3000/rails/mailers/access_mailer/notify_approvers_of_approved_access
  def notify_approvers_of_approved_access
    AccessMailer.notify_approvers_of_approved_access
  end

end
