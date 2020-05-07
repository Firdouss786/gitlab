namespace :cache do

  desc "Clears the cache"
  task clear: [:environment] do
    puts "Clearing cache..."
    Rails.cache.clear
  end

end
