module FaultStatusHelper
  def fault_status(fault)
    deferral_status = fault.deferral ? "DEFERRAL" : "FAULT"
    "#{fault.state.upcase} #{deferral_status.upcase}"
  end
end
