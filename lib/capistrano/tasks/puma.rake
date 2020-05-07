namespace :puma do

  task :restart do
    on roles(:web) do
      sudo :systemctl, "restart puma"
    end
  end
  after 'deploy:published', 'puma:restart'

end
