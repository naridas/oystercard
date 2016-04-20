
class Journey
	PENALTY_FARE = 6
	attr_reader :entry_station, :exit_station
	def initialize(entry_station = nil)#nil if the person doesn't touch in
		@entry_station = entry_station
		# @journeys = []
    	# @journey = {}
    	# @journey[:entry_station] = @entry_station
    	@complete = false
	end

	def finish(exit_station = nil)
		@exit_station = exit_station
		@complete = true
		self
    	# @journey[:exit_station] = @exit_station
    	# @journeys << @journey
	end
	 # context 'given an entry station' do
  #   subject {described_class.new(entry_station: station)}

    # it 'has an entry station' do
    #   expect(subject.entry_station).to eq station
    # end
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
		1
	end
end







