desc "Generates a random logbook reference for testing purposes"
task :logref do
  array = Array.new(7) { rand(1..9) }
  puts "NF#{array.join}"
end
