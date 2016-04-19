class Oystercard

  	MAXIMUM_BALANCE = 90
  	MINIMUM_FARE = 1

  	attr_reader :balance

  	def initialize
    	@balance = 0
  	end

  	def top_up(amount)
    	fail "Maximum balance of #{MAXIMUM_BALANCE} exceeded" if amount + balance > MAXIMUM_BALANCE
    	@balance += amount
  	end

  	def deduct(amount)
  		@balance -= amount
	end

	def in_journey?
  		@in_use
	end

	def touch_in
		fail "Need one £1 on card" if balance < MINIMUM_FARE
		@in_use = true	
	end
	def touch_out
		@in_use = false		
	end
end







# class Oystercard
# 	attr_reader :balance
# 	#DEFAULT_BALANCE = 0
# 	def intialize#(balance = DEFAULT_BALANCE)
# 		@balance = 0
# 	end

# end
