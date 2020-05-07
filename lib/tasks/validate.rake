namespace :validate do
  desc "Checks every record in a model to ensure it is valid"
  task :model, [:model_name] => [:environment] do |t, args|

    if args[:model_name]
      model_name = args[:model_name].constantize

      puts "Validating Model: #{model_name}"

      error_count = 0

      model_name.all.each do |record|
        if record.invalid?
          puts "Record #{record.id} has errors - #{record.errors.messages}"
          error_count = error_count + 1
        end
      end

      puts "Completed validating #{model_name} model with #{error_count} errors"
      puts "----------------------------"

    else
      puts "No Model name given, should be rake validate:model[\"Airport\"]"
    end

  end
end
