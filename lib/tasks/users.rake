namespace :users do

  desc "Hash old passwords"
  task hash_passwords: [:environment] do
    changed_passwords = 0
    locked_accounts = 0

    User.all.each do |user|
      user.password = user.legacy_password
      if user.save
        puts "Hashed password for user #{user.email}"
        changed_passwords += 1
      else
        puts "Validation Failed for user #{user.id} #{user.email}"
        locked_accounts += 1
      end
    end
    puts "Changed #{changed_passwords} passwords, locked #{locked_accounts} accounts."
  end

  desc "Drop old plaintext passwords"
  task drop_plaintext_passwords: [:environment] do
    # TODO: Write rake task
    puts "TASK NOT WRITTEN YET"
  end

  desc "Adds everyones home station to an access object"
  task add_home_to_access: [:environment] do
    User.all.each do |user|
      user.accesses.create accessible: user.home_station
    end
  end

  desc "Adds everyones default airline to an access object"
  task add_default_airline_to_access: [:environment] do
    User.all.each do |user|
      user.accesses.create accessible: user.default_airline
    end
  end

  desc "Seeds a demo account"
  task seed_demo: [:environment] do
    user = User.new({
      first_name: "Demo",
      last_name: "User",
      email: "demo",
      requires_verification: false,
      profile: Profile.find_by(name: "THALES SERVO ADMIN"),
      job_title: "Demo User",
      default_airline: Airline.find_by(icao_code: "AAL"),
      home_station: Station.find_by(name: "LAX"),
      password: "demo",
      password_expires_at: Date.today + 1.year,
      requires_new_user_setup: false
    })
    user.save!(validate: false)


    Access.create!(
      user: user,
      accessible: Airline.find_by(icao_code: "AAL")
    )

    Access.create!(
      user: user,
      accessible: Station.find_by(name: "LAX")
    )
  end

end
