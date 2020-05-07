namespace :db do

  # desc "Loads the latest Servo DB snapshot locally"
  # task install: :environment do
  #   puts "Pulling snapshot from backup instance..."
  #   `scp ubuntu@servo-backup.thalesinflight.com:/mnt/backups/mysqldump.bz2 tmp`
  #
  #   puts "Unzipping snapshot"
  #   `bzip2 -d tmp/mysqldump.bz2`
  #
  #   puts "Dropping database"
  #   Rake::Task["db:drop"].execute
  #
  #   puts "Creating database"
  #   Rake::Task["db:create"].execute
  #
  #   puts "Importing from tmp/mysqldump to local db"
  #   sh "mysql -u root -p#{ Rails.application.credentials.firefly_etl_database_password } firefly_etl < tmp/mysqldump"
  #
  #   puts "Cleaning up tmp files"
  #   `rm tmp/mysqldump`
  #
  #   puts "Migrating"
  #   Rake::Task["db:migrate"].execute
  # end

  desc "Firefly: Downloads latest Servo DB snapshot to the desktop"
  task download: :environment do
    puts "Pulling snapshot from backup instance..."
    `scp -i "~/Google\ Drive/Code/dev.pem" ubuntu@servo-backup.thalesinflight.com:/mnt/backups/mysqldump.bz2 tmp`

    puts "Unzipping snapshot"
    `bzip2 -d tmp/mysqldump.bz2`

    puts "Moving to desktop"
    `mv tmp/mysqldump ~/Desktop`
  end

  desc "Firefly: Imports database from desktop"
  task import: :environment do
    puts "Dropping database"
    Rake::Task["db:drop"].execute

    puts "Creating database"
    Rake::Task["db:create"].execute

    puts "Importing from mysqldump from desktop"
    `pv ~/Desktop/mysqldump | mysql -u root firefly_development`

    puts "Dumping Schema"
    Rake::Task["db:schema:dump"].execute

    puts "Migrating"
    Rake::Task["db:migrate"].execute
  end

  desc "Firefly: Exports local database to desktop"
  task export: :environment do
    puts "Exporting database"
    `mysqldump -u root firefly_development > ~/Desktop/firefly_development.sql`
  end

  desc "Firefly: loads a database that has already been migrated"
  task load: :environment do
    puts "Dropping database"
    Rake::Task["db:drop"].execute

    puts "Creating database"
    Rake::Task["db:create"].execute

    puts "Importing from mysqldump from desktop"
    `pv ~/Desktop/firefly_development.sql | mysql -u root firefly_development`
  end

  desc "Import database from staging"
  task import_from_staging: :environment do
    exec "mysqldump -u root --column-statistics=0 -p'#{Rails.application.credentials.firefly_staging_database_password}' -h firefly-staging.cqp2xwflcgyi.eu-west-2.rds.amazonaws.com firefly_staging > tmp/firefly_staging.sql && mysql -u root firefly_development < tmp/firefly_staging.sql"
  end
end
