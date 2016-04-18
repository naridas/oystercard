require 'oystercard'

describe Oystercard do
  it 'has initial balance' do
    expect(subject.balance).to eq(0)
  end
end