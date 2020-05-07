namespace :validate do
  desc "Validates All Records"
  task all: :environment do
    puts "Validating all models..."
    puts "----------------------------"

  	Rake::Task["validate:model"].invoke("Station")
    Rake::Task["validate:model"].reenable

    Rake::Task["validate:model"].invoke("Airport")
    Rake::Task["validate:model"].reenable

    Rake::Task["validate:model"].invoke("StockLocation")
    Rake::Task["validate:model"].reenable

    Rake::Task["validate:model"].invoke("User")
    Rake::Task["validate:model"].reenable

    Rake::Task["validate:model"].invoke("Profile")
    Rake::Task["validate:model"].reenable

    Rake::Task["validate:model"].invoke("Address")
    Rake::Task["validate:model"].reenable

    Rake::Task["validate:model"].invoke("Product")
    Rake::Task["validate:model"].reenable

    Rake::Task["validate:model"].invoke("ProductAllotment")
    Rake::Task["validate:model"].reenable

    Rake::Task["validate:model"].invoke("Certificate")
    Rake::Task["validate:model"].reenable

    Rake::Task["validate:model"].invoke("LevelRecommendation")
    Rake::Task["validate:model"].reenable

    Rake::Task["validate:model"].invoke("ProductCategory")
    Rake::Task["validate:model"].reenable

    Rake::Task["validate:model"].invoke("AircraftType")
    Rake::Task["validate:model"].reenable

    Rake::Task["validate:model"].invoke("Manufacturer")
    Rake::Task["validate:model"].reenable

    Rake::Task["validate:model"].invoke("Airline")
    Rake::Task["validate:model"].reenable

    Rake::Task["validate:model"].invoke("Program")
    Rake::Task["validate:model"].reenable

    Rake::Task["validate:model"].invoke("SoftwarePlatform")
    Rake::Task["validate:model"].reenable

    Rake::Task["validate:model"].invoke("AircraftConfig")
    Rake::Task["validate:model"].reenable

    Rake::Task["validate:model"].invoke("Aircraft")
    Rake::Task["validate:model"].reenable

    # Rake::Task["validate:model"].invoke("Transfer")
    # Rake::Task["validate:model"].reenable

    Rake::Task["validate:model"].invoke("StockItem")
    Rake::Task["validate:model"].reenable

    puts "Completed validating all models"
  end
end
