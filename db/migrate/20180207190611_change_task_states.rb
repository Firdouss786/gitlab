class ChangeTaskStates < ActiveRecord::Migration[5.1]
  def change
    execute <<-SQL
      UPDATE tasks
      SET state = "completed"
      WHERE state = "COMPLETED"
    SQL

    execute <<-SQL
      UPDATE tasks
      SET state = "created"
      WHERE state = "CREATED"
    SQL

    execute <<-SQL
      UPDATE tasks
      SET state = "inprogress"
      WHERE state = "IN PROGRESS"
    SQL

    execute <<-SQL
      UPDATE tasks
      SET state = "error"
      WHERE state is NULL
    SQL
  end
end
