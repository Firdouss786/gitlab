class ProgramsStation < ApplicationRecord
  belongs_to :program
  belongs_to :station

  validates :program, uniqueness: { scope: :station}
end
