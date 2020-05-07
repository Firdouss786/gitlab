namespace :tasks do

  desc "Migrate from the old template system to the new"
  task migrate: [:environment] do
    TaskService.migrate
  end

end
