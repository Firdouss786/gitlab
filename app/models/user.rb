class User < ApplicationRecord
  strip_attributes
  include NewUserSetup, PasswordValidation
  include Archivable, Searchable

  attr_accessor :reason_for_token, :requires_new_user_setup

  # Used to associate accesses which are 'enabled'
  has_many :accesses, -> { where status: "enabled" }
  has_many :airlines, through: :accesses, source: :accessible, source_type: 'Airline'
  has_many :stations, through: :accesses, source: :accessible, source_type: 'Station'

  # Used to associate accesses which are 'enabled' OR 'disabled'. Currently used
  # by the access form.
  has_many :all_accesses, class_name: "Access"
  has_many :all_airlines, through: :all_accesses, source: :accessible, source_type: 'Airline'
  has_many :all_stations, through: :all_accesses, source: :accessible, source_type: 'Station'

  has_many :fleets, through: :airlines

  has_and_belongs_to_many :approvals

  belongs_to :home_station, class_name: "Station", optional: true
  belongs_to :default_airline, class_name: "Airline", optional: true
  belongs_to :profile
  has_many :task_templates
  has_many :issues
  has_one :api_authorization
  belongs_to :airport, optional: true # Still need this for the home_station migration to work, but it will be removed once all migrations are complete. The column is gone already.

  scope :unlocked, -> { where(locked: false) }
  scope :locked, -> { where(locked: true) }

  before_save { self.email = email.downcase }

  validates :first_name, :last_name, :secondary_email, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255, minimum: 17, message: "invalid" }, uniqueness: { case_sensitive: false }
  validate :not_changing_own_profile, on: :update

  def searchable_attributes
    [email, full_name]
  end

  def admin?
    profile.name == "THALES SERVO ADMIN"
  end

  def approval_requests
    Approval.where requestee: self
  end

  def full_name
    first_name + " " + last_name
  end

  def initials
    (first_name[0] + last_name[0]).upcase
  end

  def password_expired?
    password_expires_at < DateTime.now
  end

  def secondary_email
    read_attribute(:secondary_email) || email
  end

  def full_phone_number
    if country_code && phone_number
      Country.find_by_ident(country_code).calling + " " + phone_number
    end
  end

  def self.find_by_any_email(email)
    User.find_by("email = ? OR secondary_email = ?", email, email)
  end

  def self.ordered_by_full_name
    order(first_name: :asc, last_name: :asc)
  end

  def sanitized
    attributes.except("password_digest", "token")
  end

  def permissions
    profile.permissions
  end

  def not_changing_own_profile
    errors.add(:profile, "not allowed to change your own profile") if self == Current.user && self.profile_id_changed?
  end

end
