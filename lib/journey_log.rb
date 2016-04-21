class JourneyLog

  attr_reader :journey_class, :journey_log
  

  def initialize(journey_class:Journey)
    @journey_class = journey_class
    @journey_log = []
    @current_journey = nil
  end

  def start(entry_station)
    @journey_log << (journey_class.new(entry_station:entry_station))
    @current_journey = @journey_log.last 
  end

  def finish(exit_station)
    @current_journey.exit(exit_station)
    @current_journey = nil
    @journey_log.last 
  end
  
  def journey_log
    @journey_log.dup
  end
  
  private

  def current_journey
    @current_journey || journey_class.new
  end
end