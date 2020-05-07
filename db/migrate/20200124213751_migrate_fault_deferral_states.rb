class MigrateFaultDeferralStates < ActiveRecord::Migration[6.0]

    def change

      execute <<-SQL
        UPDATE faults SET deferral = CASE
          WHEN state = 'DEFER' THEN true
          WHEN state = 'DEFER_CLOSED' THEN true
          ELSE deferral
        END
      SQL

      execute <<-SQL
        UPDATE faults SET state = CASE
          WHEN state = 'DEFER' THEN 'ACTIVE'
          WHEN state = 'DEFER_CLOSED' THEN 'CLOSED'
          ELSE state
        END
      SQL

    end

end
