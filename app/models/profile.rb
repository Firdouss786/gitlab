class Profile < ApplicationRecord

  include Searchable

  has_many :users

  has_many :permissions_profiles, dependent: :destroy
  has_many :permissions, -> { distinct }, through: :permissions_profiles

  validates :name, presence: true
  validates_uniqueness_of :name, case_sensitive: false

  def searchable_attributes
    [name, description]
  end

end
