namespace :seats do

  desc "Output seats table as yaml (for fixtures)"
  task to_yaml: [:environment] do

    Seat.all.each do |seat|
      seat = seat.as_json
      seat.delete("id")
      seat.delete("created_at")
      seat.delete("updated_at")

      puts "#{seat["name"].downcase.parameterize.underscore}:"
      seat.each do |k, v|
        puts "  #{k}: #{v}"
      end
      puts "\n"
    end
  end

end
