# Staging Server
server "10.0.31.210", user: "ubuntu", roles: %w{app web db}

# Sidekiq
set :service_unit_name, "sidekiq-#{fetch(:application)}-#{fetch(:stage)}.service"
set :init_system, :systemd
