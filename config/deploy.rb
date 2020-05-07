lock "~> 3.11.0"
set :application, "firefly"
set :repo_url, "git@github.com:thalesinflyt/firefly.git"
set :branch, `git rev-parse --abbrev-ref HEAD`.chomp
set :deploy_to, "/mnt/apps/firefly_cap"
set :bundler_path, "/home/ubuntu/.rbenv/shims/bundler"
append :linked_files, "config/credentials/staging.key"
append :linked_dirs, "log"
set :sidekiq_config, "#{current_path}/config/sidekiq.yml"
