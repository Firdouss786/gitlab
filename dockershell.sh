#!/bin/bash
#!/bin/bash
ENV_NAME="development"
echo "REDIS.flushdb" | rails c -e $ENV_NAME
echo "Search::IndexAll.new.perform" | rails c -e $ENV_NAME
#bundle exec sidekiq -C config/sidekiq.yml
#bundle exec rails c
echo "MigrateBatchConsumptionsToReplacements.perform(days_ago: 1000)" | rails c -e $ENV_NAME 
echo "MigrateRotablesToReplacements.perform(days_ago: 1000)" | rails c -e $ENV_NAME
echo "MigrateBatchConsumptionsToReplacements.perform(days_ago: 1000)" | rails c -e $ENV_NAME

#bundle exec sidekiq -C config/sidekiq.yml
#bundle exec rails c
#bundle exec puma -C config/puma.rb
#bundle exec sidekiq -C config/sidekiq.yml
#sleep 10s

#RAILS_ENV=production rails c 
#echo "REDIS.flushdb" | RAILS_ENV=production rails c 
#echo "Search::IndexAll.new.perform" | RAILS_ENV=production rails c
#bundle exec sidekiq -C ./config/sidekiq.yml ./config/environments/development.rb
#touch 1.txt
#tail -f 1.txt

