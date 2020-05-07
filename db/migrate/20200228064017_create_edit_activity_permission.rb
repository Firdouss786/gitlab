class CreateEditActivityPermission < ActiveRecord::Migration[6.0]
  def change
    Permission.create(:name => "Edit Activity", :description => "Can edit anyone activity", :subject_class => "activity", :action => "update")
  end
end
