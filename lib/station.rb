class Station

  attr_reader :name, :zone

  def initialize(name, zone) #changed to symbols
    @name = name
    @zone = zone
  end
end