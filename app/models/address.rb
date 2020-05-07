class Address < ApplicationRecord

  has_one :station

  validates :zip, :street1, :city, :country, presence: true

  def full_address
    address = street1
    if !street2.nil?
      address = address + ", " + street2
    end
    address + ", " + city + ", " + country + " - " + zip
  end

end
