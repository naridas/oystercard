class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1

  attr_reader :balance, :entry_station, :journeys, :journey

  def initialize
    @balance = 0
    @journeys = []
    @journey = {}
  end

  def top_up(amount)
    fail "Maximum balance of #{MAXIMUM_BALANCE} exceeded" if balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(entry_station)
    fail "Not enough balance on card" if balance < MINIMUM_FARE
    @entry_station = entry_station
    journey[:entry_station] = entry_station
  end

  def touch_out(exit_station)
    deduct(MINIMUM_FARE)
    @entry_station = nil
    journey[:exit_station] = exit_station
    journeys << journey
  end
  def in_journey?
   !!entry_station
  end

  private
  def deduct(fare)
    @balance -= fare
  end

end
