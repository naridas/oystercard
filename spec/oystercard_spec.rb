require 'oystercard'

describe Oystercard do
  it 'has initial balance' do
    expect(subject.balance).to eq(0)
  end

  it 'tops up the balance' do
    expect{ subject.top_up 30 }.to change{ subject.balance }.by 30
  end

  it 'raises and error if top up amount increase balance past £90' do
    expect{ subject.top_up (91) }.to raise_error "Maximum limit exceeded by 1!"
  end


# Use test-driven development approach to update the top_up method to raise an error if the action would take the card beyond the limit.

end
