class Approver < ApplicationRecord
  belongs_to :user
  belongs_to :approval

  enum state_selected: { pending: "pending", approved: "approved", rejected: "rejected" }

end
