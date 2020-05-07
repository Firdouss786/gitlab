class BomUploadsController < ApplicationController
  include FleetScoped

  before_action :set_fleet

  def new
  end

  def create
    parsed_msg = helpers.parse_excel?(params[:file], @fleet) if valid_file?(params[:file])

    respond_to do |format|
      if parsed_msg && parsed_msg.first
        format.html { redirect_to product_allotments_path(@fleet), notice: parsed_msg.second }
      else
        format.html { redirect_to new_bom_upload_path(@fleet), notice: parsed_msg.try(:second) || "File missing or not in .xlsx format." }
      end
    end
  end

  private
    def valid_file?(file)
      file.present? && helpers.excel_file?(file)
    end
end
