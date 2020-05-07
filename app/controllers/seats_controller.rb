class SeatsController < ApplicationController
  before_action :set_fleet

  # GET /seats
  # GET /seats.json
  def index
    @seats = @fleet.seats
  end

  # GET /seats/new
  def new
    @seat = Seat.new
  end

  # POST /seats
  def create
    uploaded_file = params[:file]

    # Create new config_file record.
    @fleet_file = ConfigFile.new
    @fleet_file.fleet = @fleet
    @fleet_file.user = Current.user

    # Attach uploaded file to ActiveStorage
    @fleet_file.config_file_payload.attach(uploaded_file)

    # Call seat parsing service as per dat or xml file uploaded.
    if File.extname(uploaded_file.path) == '.dat'
      @fleet_file.file_type = 'seatdat'
      @final_array = ExtractSeats.parse_seat_dat(uploaded_file, params[:fleet_id])
    elsif File.extname(uploaded_file.path) == '.xml'
      @fleet_file.file_type = 'template'
      @final_array = ExtractSeatsXml.parse_seat_xml(uploaded_file, params[:fleet_id])
    end

    # Check and delete if this fleeturation has any existing seats.
    @fleet.seats.each do |seat|
      seat.destroy
    end

    # This will insert all seat records in the hash, one by one.
    @final_array.each do |row|
      @Seats = Seat.create(row)
    end


    # Update AircraftCofig ConfigFile information.
    @fleet.touch(:updated_at)
    @fleet.update(config_file: @fleet_file)
    redirect_to seats_path(@fleet)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fleet
      @fleet = Fleet.find(params[:fleet_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def seat_params
      params.require(:seat).permit(:name, :col, :row, :travel_class, :deck, :dsu_primary, :dsu_secondary, :fleet_id)
    end
end
