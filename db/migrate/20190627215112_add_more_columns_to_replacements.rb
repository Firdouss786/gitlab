class AddMoreColumnsToReplacements < ActiveRecord::Migration[6.0]
  def change
    add_reference :replacements, :installed_product, foreign_key: { to_table: :products }
    add_reference :replacements, :removed_product, foreign_key: { to_table: :products }
    add_column :replacements, :removed_model_numbers, :string
    add_column :replacements, :removed_revision, :string
  end
end
