class Deferral
  include ActiveModel::Model
  
  def self.all
    Fault.deferred
  end

end
