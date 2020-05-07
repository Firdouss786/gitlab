class Country
  attr_accessor :ident, :calling

  def initialize(country)
    @ident = country.alpha3
    @calling = country.calling
  end

  def self.all
    IsoCountryCodes.all.map {|iso_country| Country.new(iso_country)}
  end

  def self.find_by_ident(ident)
    Country.all.select { |country| country.ident == ident }.first
  end

  def ident_with_calling
    ident + " " + calling
  end

  def self.names
    IsoCountryCodes.all.map { |country| country.name }
  end

end
