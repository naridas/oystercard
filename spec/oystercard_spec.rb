# in spec/oystercard_spec.rb
require 'oystercard'

describe Oystercard do
	subject(:oystercard) {described_class.new}
	it 'has a balance of zero' do
    	expect(oystercard.balance).to eq(0)
  	end

	describe '#top_up' do

  		#it { is_expected.to respond_to(:top_up).with(1).argument }

  		it 'can top up the balance' do
    		expect{ oystercard.top_up 1 }.to change{ oystercard.balance }.by 1
    	end
    	it 'raises an error if the maximum balance is exceeded' do
  			MAXIMUM_BALANCE = Oystercard::MAXIMUM_BALANCE
  			oystercard.top_up MAXIMUM_BALANCE
  			expect{ oystercard.top_up 1 }.to raise_error "Maximum balance of #{MAXIMUM_BALANCE} exceeded"
		end
  	end

	describe '#deduct' do

  		#it { is_expected.to respond_to(:deduct).with(1).argument }

  		it 'deducts an amount from the balance' do
    		oystercard.top_up(20)
    		expect{ oystercard.deduct 3}.to change{ oystercard.balance }.by -3
  		end
  	end

  	context 'touch_in/touch_out' do
  		describe '#in_out' do
  			it "can touch in" do
  				oystercard.top_up(Oystercard::MINIMUM_FARE)
  				oystercard.touch_in
  				expect(oystercard).to be_in_journey
			end
    		it 'raises an error if the £1 not on card' do
  				MINIMUM_FARE = Oystercard::MINIMUM_FARE
  				oystercard.top_up(MINIMUM_FARE-1)
  				expect{ oystercard.touch_in}.to raise_error "Need one £1 on card" 
			end
  		end
  		it 'is initially not in a journey' do
  			expect(oystercard).not_to be_in_journey
		end

		it "can touch out" do
			oystercard.top_up(Oystercard::MINIMUM_FARE)
  			oystercard.touch_in
  			oystercard.touch_out
  			expect(oystercard).not_to be_in_journey
		end
  	end
end
