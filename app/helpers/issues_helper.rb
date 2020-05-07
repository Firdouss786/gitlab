module IssuesHelper
  def state_button(issue)
    if issue.created?
      link_to("Approve", issue_approve_path(issue), method: "put")
    elsif issue.approved?
      "Approved"
    end
  end
end
