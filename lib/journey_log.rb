class JourneyLog

  attr_reader :journeys, :journey

  def initialize(journey_class = Journey.new)
    @journey_class = journey_class
    @journeys = []
    @journey = {}
  end

  def start(entry_station)
    @entry_station = entry_station
    Journey.new(entry_station = station)
    journey[:entry_station] = entry_station
  end


    def start_journey(station)
    fail 'Already in a Journey.' if current_journey.entry_station
    add(journey_class.new(entry_station: station))
  end

  def finish(exit_station)
    journey[:exit_station] = exit_station
    journeys << journey
  end

end