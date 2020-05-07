desc "Generated a new ROTP token"
task rotp_token: [:environment] do
  puts ROTP::Base32.random
end
