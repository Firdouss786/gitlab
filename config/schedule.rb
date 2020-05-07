env :PATH, ENV['PATH']

every 5.minutes, roles: [:app] do
  set :output, '/mnt/apps/firefly_cap/shared/cron.log'

  rake "etl:run", :environment => 'etl'
end
