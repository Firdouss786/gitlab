namespace :etl do
  desc "Runs the database ETL jobs"

  task run: :environment do
    if Rails.env == "etl"
      Dir.chdir('/mnt/apps/firefly/') do
        puts "Downloading Servo database snapshot"
        `scp ubuntu@servo-backup.thalesinflight.com:/mnt/backups/mysqldump.bz2 /tmp`

        puts "Unzipping snapshot"
        `bzip2 -d /tmp/mysqldump.bz2`

        puts "Drop local Firefly database"
        `RAILS_ENV=etl DISABLE_DATABASE_ENVIRONMENT_CHECK=1 rake db:drop`

        puts "Create local Firefly database"
        `RAILS_ENV=etl rake db:create`

        puts "Load snapshot to local Firefly database"
        `pv /tmp/mysqldump | mysql -u root -p#{Rails.application.credentials.firefly_etl_database_password} firefly_etl`

        start_time = Time.now

        puts "Migrate local Firefly database. This will take about 40 mins. Started at #{Time.now} UTC"
        `RAILS_ENV=etl rake db:migrate`

        puts "Migration completed in #{Time.now - start_time}"

        puts "Seed Database"
        `RAILS_ENV=etl rake db:seed`

        puts "Unsubscribe all FA alerts"
        `RAILS_ENV=etl rake flight:unsubscribe_all`

        puts "Flush any remaining FA alerts"
        `RAILS_ENV=etl rake flight:flush_all_alerts`

        puts "Setup FA Subscription"
        `RAILS_ENV=etl rake flight:setup_subscription`

        puts "Subscribe all FA"
        `RAILS_ENV=etl rake flight:subscribe_all`

        puts "Migrate Tasks"
        `RAILS_ENV=etl rake tasks:migrate`

        puts "Hash Passwords"
        `RAILS_ENV=etl rake users:hash_passwords`

        puts "Dump the local Firefly Database"
        `mysqldump -u root -p#{Rails.application.credentials.firefly_etl_database_password} firefly_etl > /home/ubuntu/firefly_etl.sql`

        puts "Drop Staging Database"
        `rails db:environment:set RAILS_ENV=staging`
        `RAILS_ENV=staging rake db:drop`

        puts "Create Staging Database"
        `RAILS_ENV=staging rake db:create`

        puts "Load Staging Database from ETL"
        `pv /home/ubuntu/firefly_etl.sql | mysql -u root -p"#{Rails.application.credentials.firefly_staging_database_password}" firefly_staging -h firefly-staging.cqp2xwflcgyi.eu-west-2.rds.amazonaws.com`

        puts "Cleanup old files"
        `rm /tmp/mysqldump`
        `rm /home/ubuntu/firefly_etl.sql`
      end
    else
      puts "Skipping ETL job, not ETL environment"
    end
  end

end
