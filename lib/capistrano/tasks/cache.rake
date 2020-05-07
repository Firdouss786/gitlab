namespace :cache do

  task :clear do
    on roles(:web) do
      within release_path do
        execute :bundle, 'exec rails cache:clear'
      end
    end
  end

end
