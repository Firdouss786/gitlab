class Station < ApplicationRecord
  include Searchable

  validates :airport, :user, :name, presence: true
  validates_uniqueness_of :name, case_sensitive: false

  belongs_to :airport
  belongs_to :user
  belongs_to :address
  accepts_nested_attributes_for :address

  has_many :stock_locations, as: :parent
  has_many :activities

  has_many :accesses, -> { enabled }, as: :accessible
  has_many :users, through: :accesses

  has_and_belongs_to_many :programs
  has_many :airlines, through: :programs

  def searchable_attributes
    [name, self.airport.name, self.address.street1]
  end

  def full_address
    address.full_address
  end

  def accessible_resource_name
    name
  end

  def accessible_approvers
    # TODO: Update once we get the station managers thing in place
    [User.find_by(email: "albert@thalesinflight.com")]
  end

  def default_program
    # TODO: remodel this.
    programs.first.airline
  end
end
