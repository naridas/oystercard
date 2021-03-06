# in spec/oystercard_spec.rb
require 'oystercard'

describe Oystercard do
	#subject(:oystercard) {desribed_class.new}
	it 'has a balance of zero' do
    	expect(subject.balance).to eq(0)
  	end

	describe '#top_up' do

  		#it { is_expected.to respond_to(:top_up).with(1).argument }

  		it 'can top up the balance' do
    		expect{ subject.top_up 1 }.to change{ subject.balance }.by 1
    	end
    	it 'raises an error if the maximum balance is exceeded' do
  			MAXIMUM_BALANCE = Oystercard::MAXIMUM_BALANCE
  			subject.top_up MAXIMUM_BALANCE
  			expect{ subject.top_up 1 }.to raise_error "Maximum balance of #{MAXIMUM_BALANCE} exceeded"
		end
  	end

	describe '#deduct' do

  		#it { is_expected.to respond_to(:deduct).with(1).argument }

  		it 'deducts an amount from the balance' do
    		subject.top_up(20)
    		expect{ subject.deduct 3}.to change{ subject.balance }.by -3
  		end
  	end

  	describe 'touch_in/touch_out' do
  		it 'is initially not in a journey' do
  			expect(subject).not_to be_in_journey
		end

		it "can touch in" do
  			subject.touch_in
  			expect(subject).to be_in_journey
		end

		it "can touch out" do
  			subject.touch_in
  			subject.touch_out
  			expect(subject).not_to be_in_journey
		end
  	end
end
