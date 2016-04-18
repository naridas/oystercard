require 'oystercard'

describe Oystercard do
  it 'has initial balance' do
    expect(subject.balance).to eq(0)
  end

  describe '#top_up' do
    it 'tops up the balance' do
      expect{ subject.top_up 30 }.to change{ subject.balance }.by 30
    end
    it 'raises and error if top up amount increase balance past £90' do
      expect{ subject.top_up (91) }.to raise_error "Maximum limit exceeded by 1!"
    end
  end
  
  describe '#deduct' do
    it 'deducts the fare from the card' do
      subject.top_up(30)
      expect{ subject.deduct 10 }.to change{ subject.balance }.by -10
    end
  end

end
