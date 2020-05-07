# This class is only used for initial indexing, and is not part of regular operation

class Search::IndexAll
  include ActiveModel::Model

  attr_reader :models

  def initialize
    @models = [:airline, :aircraft, :user, :airport, :manufacturer, :discrepancy, :defer_reason, :software_platform, :maintenance_action, :product_category, :product, :station, :fleet, :task_template, :discrepancy_category, :profile, :fault, :campaign]
  end

  def perform
    models.each {|a| index_all_records_for_model(a) }
  end

  private

    def index_all_records_for_model(model_name)
      model_name.to_s.classify.constantize.all.each do |document|
        document.index_document
      end
    end
end
