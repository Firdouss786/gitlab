class AirlineAccess < ApplicationRecord
  belongs_to :user
  belongs_to :airline

  validates :user, uniqueness: { scope: :airline }
end
