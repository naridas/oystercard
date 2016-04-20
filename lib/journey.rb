class Journey

  PENALTY_FARE = 6
  attr_reader :entry_station, :exit_station

  def initialize(entry_station = nil)
    @entry_station = entry_station
    @complete = false
  end

  def finish(exit_station = nil)
    @exit_station = exit_station
    @complete = true
    self
  end

  def complete?
    @complete
  end

  # def zones
  # 	@zonea = 5
  # 	@zoneb = 1
  # 	(@zone1 - @zone2).abs
  # end

  def fare
    return PENALTY_FARE if (exit_station.nil? || entry_station.nil?)
		# zones + 1
    1
  end
end