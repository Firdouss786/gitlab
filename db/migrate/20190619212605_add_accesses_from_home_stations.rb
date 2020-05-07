class AddAccessesFromHomeStations < ActiveRecord::Migration[6.0]
  def up
    Rake::Task['users:add_home_to_access'].invoke
  end

  def down
    puts "Skipping, unable to reverse rake task"
  end
end
