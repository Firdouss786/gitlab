class ReworkArchivalsTable < ActiveRecord::Migration[6.0]
  def change
    remove_column :archivals, :archivable_id
    remove_column :archivals, :archivable_type

    add_column :archivals, :reason, :string
  end
end
