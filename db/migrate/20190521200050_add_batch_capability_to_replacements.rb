class AddBatchCapabilityToReplacements < ActiveRecord::Migration[6.0]
  def change
    add_column :replacements, :install_quantity, :integer
    add_column :replacements, :category, :string
  end
end
