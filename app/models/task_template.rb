class TaskTemplate < ApplicationRecord
  include Archivable, TaskGenerator, Searchable

  attr_accessor :applicable_content, :applicable_software, :selected

  before_save :update_task_archivals, if: Proc.new { |template| template.archival_id_changed? }

  belongs_to :airline
  # TODO: this should probable be set in a migration rather than being optional
  belongs_to :user, optional: true

  has_one :campaign

  has_many :config_applicabilities
  has_many :fleets, through: :config_applicabilities
  has_many :tasks

  enum mode: { campaign: "campaign", recurring: "recurring" }

  accepts_nested_attributes_for :config_applicabilities, reject_if: :applicability_not_selected
  accepts_nested_attributes_for :campaign, reject_if: :not_campaign

  validates :name, presence: true
  validates :repeat_interval, presence: true, if: :recurring?
  validates_presence_of :mode

  def searchable_attributes
    [name]
  end

  def applicability_not_selected(attributes)
    attributes['selected'] == "0"
  end

  def not_campaign
    not campaign?
  end

  private
    def update_task_archivals
      if archival_id_was.nil?
        tasks.each {|task| task.archive_by Current.user }
      else
        # TODO Fixme. Not able to restore child tasks upon restoration of template
        # tasks.each {|task| task.restore }
      end
    end

end
