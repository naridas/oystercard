
class Journey
	PENALTY_FARE = 10
	attr_reader :entry_station
	def initialize(entry_station = PENALTY_FARE)
		@entry_station = entry_station
		@journeys = []
    	@journey = {}
    	@journey[:entry_station] = @entry_station
	end

	def finish(exit_station)
		@exit_station = true
    	@journey[:exit_station] = @exit_station
    	@journeys << @journey
	end
	 # context 'given an entry station' do
  #   subject {described_class.new(entry_station: station)}

    # it 'has an entry station' do
    #   expect(subject.entry_station).to eq station
    # end
	def complete?
		!!@exit_station
	end


	def fare
		PENALTY_FARE unless complete?
	end
end







