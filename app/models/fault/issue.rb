class Fault::Issue < Fault
  validates :mcc_description, presence: true
end
