class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1

  attr_reader :balance, :entry_station, :journeys

  def initialize
    @balance = 0
    @journeys = []
  end

  def top_up(amount)
    fail "Maximum balance of #{MAXIMUM_BALANCE} exceeded" if amount + balance > MAXIMUM_BALANCE
    @balance += amount
  end

	def in_journey?
  	!!entry_station
	end

	def touch_in(station)
		fail "Need one £1 on card" if balance < MINIMUM_FARE
    @entry_station = station
	end

	def touch_out(exit_station)
		deduct(MINIMUM_FARE)
    record(exit_station)
    @entry_station = nil
	end

  def record(exit_station)
    hash = {}
    hash[entry_station] = exit_station
    @journeys << hash
  end

	private

	def deduct(amount)
  	@balance -= amount
	end

end
