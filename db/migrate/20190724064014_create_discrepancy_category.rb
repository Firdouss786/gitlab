class CreateDiscrepancyCategory < ActiveRecord::Migration[6.0]

  class DiscrepancyCategory < ApplicationRecord
    validates :category, presence: true
    validates_uniqueness_of :category, case_sensitive: false
  end

  def self.up

    create_table :discrepancy_categories do |t|
      t.string :category, null: false, index: { unique: true }
      t.timestamps
    end

    categories = Discrepancy.distinct.pluck(:category)
    categories.each { |category| CreateDiscrepancyCategory::DiscrepancyCategory.create(category: category) }

  end

  def self.down
    drop_table :discrepancy_categories
  end

end
