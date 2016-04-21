require_relative 'oystercard'
require_relative 'journey_log'
class Journey

  PENALTY_FARE = 6
  attr_reader :entry_station, :exit_station

  def initialize(entry_station:nil)
    @entry_station = entry_station
    @complete = false
  end

  def exit(exit_station = nil)
    @exit_station = exit_station
    @complete = true
    self
  end

  def complete?
    @complete
  end

  def zones
   	 [entry_station, exit_station].map(&:zone).sort{|a,b| b <=> a }
  end

  def fare
    return PENALTY_FARE if (exit_station.nil? || entry_station.nil?)
		zones.inject(:-) + 1
  end
end