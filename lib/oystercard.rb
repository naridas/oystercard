class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1

  attr_reader :balance, :entry_station

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    fail "Maximum balance of #{MAXIMUM_BALANCE} exceeded" if balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end

  def in_journey?
    @in_journey  # we need to refactor
  end

  def touch_in(entry_station)
    fail "Not enough balance on card" if balance < MINIMUM_FARE
    @in_journey = true
    @entry_station = entry_station
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @in_journey = false
    @entry_station = nil
  end

  private
  def deduct(fare)
    @balance -= fare
  end

end