class Station

  attr_reader :name, :zone

  def initialize(args)
    @name = args[:name]
    @zone = args[:zone]
    @zone2 = args[:zone2]
  end
end