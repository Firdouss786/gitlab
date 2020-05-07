# Approvals
Approval is a polymorphic object, and so it can attach to any other object in the system. The `Approval` is just an object which keeps state. It expects its 'approvable' object to have the following methods:

`approve!` - This will be called by the approval class.

### Communications
The approvable class is expected to handle all communications, since they are likely specific to each scenario. The `Approval` class itself will not send out anything.

### Example
Here is a simple setup:

```
class Article < ApplicationRecord
  include Approvable

  enum status: [draft, published]

  after_create do
    draft!
    request_approval
  end

  def approve!
    published!
    notify_approvers_of_new_article
  end

  def notify_approvers_of_new_article
    ArticleMailer.notify_approvers_of_new_article(self).deliver_later
  end

  private
    def request_approval
      Approval.create approvable: self, requestee: self.user, users: [User.first, User.second]
    end
end
```

The `Approvable` concern gives us access to the approval itself, so in the above example you could call `self.approval.users`, or `self.approval.requestee`.

### Approval Users
The approval has a `requestee` (the person requesting the approval), and `users` (the users which are able to approve the request).
