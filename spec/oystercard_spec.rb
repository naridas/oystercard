require 'oystercard'

describe Oystercard do
  it 'has initial balance' do
    expect(subject.balance).to eq(0)
  end

  it 'tops up the balance' do
    expect{ subject.top_up 30 }.to change{ subject.balance }.by 30
  end

end
