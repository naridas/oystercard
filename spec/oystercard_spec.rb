require 'oystercard'

describe Oystercard do
  describe "when new card issues" do
    it 'has initial balance' do
      expect(subject.balance).to eq(0)
    end
  end

  describe '#top_up' do
    it 'tops up the balance' do
      expect{ subject.top_up 30 }.to change{ subject.balance }.by 30
    end
    it 'raises an error if the maximum balance is exceeded' do
      maximum_balance = Oystercard::MAXIMUM_BALANCE
      subject.top_up maximum_balance
      error_maximum = "Maximum balance of #{Oystercard::MAXIMUM_BALANCE} exceeded"
      expect{ subject.top_up 1 }.to raise_error error_maximum
    end
  end

  describe '#deduct' do
    it 'deducts the fare from the card' do
      subject.top_up(30)
      expect{ subject.deduct 10 }.to change{ subject.balance }.by -10
    end
  end

end
