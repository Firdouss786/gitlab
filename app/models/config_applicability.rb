class ConfigApplicability < ApplicationRecord
  belongs_to :fleet
  belongs_to :task_template

  has_one_attached :task_document

  attr_accessor :selected
end
