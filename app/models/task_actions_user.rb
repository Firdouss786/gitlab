class TaskActionsUser < ApplicationRecord
  belongs_to :task_action
  belongs_to :user
end
