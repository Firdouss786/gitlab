class ActivitiesIsOpenToState < ActiveRecord::Migration[6.0]
  def change
    execute <<-SQL
      UPDATE activities
        SET state = CASE
          WHEN is_open = 0 THEN 'COMPLETE'
          WHEN is_open = 1 THEN 'OPEN'
        END
    SQL
  end
end
