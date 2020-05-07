class AddEmailFeatureFlag < ActiveRecord::Migration[6.0]
  def change
    FeatureFlag.create(:name => "email_two_step_verification", :enabled => 1)
  end
end
