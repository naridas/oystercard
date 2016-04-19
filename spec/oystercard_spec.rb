# in spec/oystercard_spec.rb
require 'oystercard'

describe Oystercard do
	subject(:oystercard) {described_class.new}
  let(:station) { double(:station) }
	let(:minimum_fare) {Oystercard::MINIMUM_FARE}
  let(:oyster_topped) do
    oystercard = Oystercard.new
    oystercard.top_up(minimum_fare)
    oystercard.touch_in(station)
    oystercard
  end

	describe '#top_up' do

  	it 'can top up the balance' do
    	expect{ oystercard.top_up 1 }.to change{ oystercard.balance }.by 1
    end
    it 'raises an error if the maximum balance is exceeded' do
  		oystercard.top_up Oystercard::MAXIMUM_BALANCE
  		expect{ oystercard.top_up 1 }.to raise_error "Maximum balance of #{Oystercard::MAXIMUM_BALANCE} exceeded"
		end
  end

  context 'touch_in/touch_out' do
  	describe '#touch_in' do
  		it "can touch in" do
  			expect(oyster_topped).to be_in_journey
			end
    	it 'raises an error if the £1 not on card' do
  			oystercard.top_up(minimum_fare-1)
  			expect{ oystercard.touch_in(station)}.to raise_error "Need one £1 on card"
			end
      # it 'remembers entry station when touch in' do
      #  oystercard.top_up(minimum_fare)
      #  expect(oystercard.touch_in(station)).to eq station
      # end
      it 'remembers entry_station when touch_in' do
        expect(oyster_topped.entry_station).to eq station
  		end
  		# it 'is initially not in a journey' do
  		# 	expect(oystercard).not_to be_in_journey
      # end
		end

		context '#touch_out' do
			it "can touch out" do
  			oyster_topped.touch_out
  			expect(oyster_topped).not_to be_in_journey
			end
			it 'raises an error if the £1 not on card' do
  			expect{ oyster_topped.touch_out}.to change{ oyster_topped.balance }.by -minimum_fare
			end
      it 'forgets entry station on touch_out' do
        oyster_topped.touch_out
        expect(oyster_topped.entry_station).to eq nil
      end
		end
  end
end
