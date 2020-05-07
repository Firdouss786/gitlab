class ExtractSeatsXml
  @tmp_buddy_seats = Array.new
  def initialize(file)
    @file = file
  end

  private
    # Receives an uploaded filepath and fleet_id in arguments,
    # and returns array of hash containing seats information.
    def self.parse_seat_xml(filePath,fleet_id)
      file_content = filePath.read
      
      # Break down complete file first.
      seat_hash = Hash.from_xml(file_content)
			
      final_array = Array.new

      final_array = self.extract_seat_data(seat_hash,fleet_id)

      # Remove buddy seats from final_array.
      # @tmp_buddy_seats.each do |buddy_seat|
      #   final_array.delete_if {|seat| seat[:name] == buddy_seat[:seat_name]}
      # end

      # Remove seats with name as 'ICMT' in it.
      final_array.delete_if {|seat, name| seat[:name].include?('ICMT')}

      final_array
    end

		# Function to extract seat data and create hash of it.
    def self.extract_seat_data(seat_hash, fleet_id)
      tmp_array = Array.new

      seat_hash["SeatLocation"]["Zone"].each do |zone|
        zone["SeatBox"].each do |seat_array|
          seat_array["Seat"].each do |seat|
            if seat["seatProfile"] != "Unused"
              tmp_hash = Hash.new
              # Get particular value from seat array element for creating hash.
              tmp_hash.merge!({name: seat["rowId"].tr('"', '') + seat["seatId"].tr('"', '')})
              tmp_hash.merge!({col: seat["seatId"].tr('"', '')})
              tmp_hash.merge!({row: seat["rowId"].tr('"', '')})
              case zone["seatProfile"].tr('"', '').tr(" ","")
                when "Coach" then tmp_hash.merge!({travel_class: 4})
                when "FirstClass" then tmp_hash.merge!({travel_class: 1})
                else tmp_hash.merge!({travel_class: 4})
              end
              tmp_hash.merge!({deck: 1})
              tmp_hash.merge!({dsu_primary: ''})
              tmp_hash.merge!({dsu_secondary: ''})
              tmp_hash.merge!({fleet_id: fleet_id})
              tmp_array.push << tmp_hash
            end
          end
        end
      end

      tmp_array
    end
end