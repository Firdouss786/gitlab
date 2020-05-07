class StationAccessMailer < ApplicationMailer
  default from: 'FireFly@thalesinflight.com'

  def approval
    @approver = params[:approver]
    @requestee = params[:requestee]
    @approvable = params[:approvable]
    @expiry = params[:expiry]
    @approval_token = params[:approval_token]
    mail to: @approver.email, reply_to: @requestee.email, subject: "Station Access Request (#{@requestee.full_name} to #{@approvable.station.name.upcase})"
  end

  def acknowledgement
    @requestee = params[:requestee]
    @approver = params[:approver]
    @approvable = params[:approvable]
    mail to: @requestee.email, reply_to: @approver.email, subject: "Update: Station Access Request (#{@requestee.full_name} to #{@approvable.station.name.upcase})"
  end

end
