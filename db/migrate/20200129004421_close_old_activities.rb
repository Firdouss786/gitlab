class CloseOldActivities < ActiveRecord::Migration[6.0]
  def change
    Activity.active.where("created_at < ?", 5.days.ago).update_all(state: "COMPLETE")
  end
end
