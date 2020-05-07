class CleanTransfers < ActiveRecord::Migration[5.1]
  def change

    # Fill in the users we know about
    execute <<-SQL
      UPDATE transfers
      SET created_by_id = sent_by_id
      WHERE created_by_id is NULL
    SQL

    execute <<-SQL
      UPDATE transfers
      SET created_by_id = received_by_id
      WHERE created_by_id is NULL
    SQL

    # Set the rest to John Doe as they all look like corrections
    execute <<-SQL
      UPDATE transfers
      SET created_by_id = 74
      WHERE created_by_id is NULL
    SQL

  end
end
