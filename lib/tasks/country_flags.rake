namespace :country_flags do

  desc "Downloads country flag images from freeflagicons.com for the airports in our database"
  task download: [:environment] do
    Station.all.each do |station|
      country = station.airport.country.parameterize.underscore
      url = "http://img.freeflagicons.com/thumb/round_icon/#{country}/#{country}_64.png"

      result = HTTParty.get(url)

      if result.response.class == Net::HTTPNotFound
        puts "Could not find flag for #{country}: #{url}"
      else
        open("app/assets/images/flags/#{country}.png", 'wb') do |file|
          file << open(url).read
        end
      end

    end
  end
end
