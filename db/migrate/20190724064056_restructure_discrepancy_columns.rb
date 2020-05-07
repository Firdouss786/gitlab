class RestructureDiscrepancyColumns < ActiveRecord::Migration[6.0]

  def self.up

    add_reference :discrepancies, :discrepancy_category, index: true
    add_reference :discrepancies, :archival, index: true
    add_index :discrepancies, [:name, :discrepancy_category_id], unique: true

    DiscrepancyCategory.all.each do |c|
      Discrepancy.where(category: c.category).update_all(discrepancy_category_id: c.id)
    end

    remove_column :discrepancies, :category
    remove_column :discrepancies, :description

  end

  def self.down
    remove_index :discrepancies, [:name, :discrepancy_category_id]
    remove_reference :discrepancies, :discrepancy_category, index: true
    remove_reference :discrepancies, :archival, index: true
    add_column :discrepancies, :category, :string
    add_column :discrepancies, :description, :text
  end

end
