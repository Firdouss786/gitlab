class ExtractSeats
  @tmp_buddy_seats = Array.new
  def initialize(file)
    @file = file
  end

  private
    # Receives an uploaded filepath and fleet_id in arguments,
    # and returns array of hash containing seats information.
    def self.parse_seat_dat(filePath,fleet_id)
      file_content = filePath.read

      # Break down complete file first.
      seats = file_content.split(";\n\n")
      final_array = Array.new

      seats.each do |seat|
        # Fetch individual seat data and push it in final_array.
        final_array.push << self.extract_seat_data(seat,fleet_id)
      end

      # Remove buddy seats from final_array.
      @tmp_buddy_seats.each do |buddy_seat|
        final_array.delete_if {|seat| seat[:name] == buddy_seat[:seat_name]}
      end

      # Remove seats with name or col as 'ICMT' in it.
      final_array.delete_if {|seat, name| seat[:name].include?('ICMT')}
      final_array.delete_if {|seat, col| seat[:col].include?('ICMT')}

      final_array
    end

		# Function to extract seat data and create hash of it.
    def self.extract_seat_data(seat, fleet_id)
      tmp_hash = Hash.new
      final_hash = Hash.new
      properties = seat.split(",\n")

      # Create hash for each seat's data.
      tmp_hash = properties.map{|element| element.split '=' }.to_h
      tmp_hash = tmp_hash.transform_keys{|key| key.tr(' ', '')}
      tmp_hash = tmp_hash.transform_values{|value| value.tr(' ', '')}

      final_hash.merge!({name: tmp_hash["seat"].tr('"', '')})
      final_hash.merge!({col: tmp_hash["acSeatLetter"].tr('"', '')})

      if tmp_hash.key?("pavamapRow")
        final_hash.merge!({row: tmp_hash["pavamapRow"].tr('"', '')})
      elsif tmp_hash.key?("acSeatRow")
        final_hash.merge!({row: tmp_hash["acSeatRow"].tr('"', '')})
      end

      if tmp_hash.key?("acCabinNbr")
        final_hash.merge!({travel_class: tmp_hash["acCabinNbr"].tr('"', '')})
      elsif tmp_hash.key?("classNbr")
        final_hash.merge!({travel_class: tmp_hash["classNbr"].tr('"', '')})
      end

      if tmp_hash.key?("acDeckType")
        if tmp_hash["acDeckType"].tr('"', '') == "0" || tmp_hash["acDeckType"].tr('"', '') == "1"
          final_hash.merge!({deck: "1"})
        elsif tmp_hash["acDeckType"].tr('"', '') == "2"
          final_hash.merge!({deck: "2"})
        end
      else
        final_hash.merge!({deck: "1"})
      end

      if tmp_hash.key?("buddySeat")
        @tmp_buddy_seats << {seat_name: tmp_hash["buddySeat"].tr('"', '')}
      end

      final_hash.merge!({dsu_primary: ''})
      final_hash.merge!({dsu_secondary: ''})
      final_hash.merge!({fleet_id: fleet_id})

      final_hash
    end
end