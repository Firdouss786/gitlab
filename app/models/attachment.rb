class Attachment < ApplicationRecord
  belongs_to :fault
  belongs_to :user

  has_one_attached :file
end
