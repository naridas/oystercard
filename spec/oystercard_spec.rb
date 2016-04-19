require "oystercard"

describe Oystercard do

  let(:loaded_card) do
    loaded_card = Oystercard.new
    loaded_card.top_up(Oystercard::MAXIMUM_BALANCE)
    loaded_card
  end

  context "when new card issues" do
    it "has initial balance" do
      expect(subject.balance).to eq(0)
    end

    it "journey? is false" do
      expect(subject.in_journey?).to be false
    end
  end

  context "#top_up" do
    it "tops up the balance" do
      expect{ subject.top_up 30 }.to change{ subject.balance }.by 30
    end
    it "raises an error if the maximum balance is exceeded" do
      maximum_balance = Oystercard::MAXIMUM_BALANCE
      subject.top_up maximum_balance
      error_maximum = "Maximum balance of #{Oystercard::MAXIMUM_BALANCE} exceeded"
      expect{ subject.top_up 1 }.to raise_error error_maximum
    end
  end

  context "when touch in" do
    it "requires a minimal balance of £1" do
      expect{ subject.touch_in }.to raise_error "Not enough balance on card"
    end
  end

  context "#deduct" do
    it "deducts the fare from the card" do
      subject.top_up(30)
      expect{ subject.deduct 10 }.to change{ subject.balance }.by -10
    end
  end

  context "add touch_in and out" do
    it "can touch in" do
      loaded_card.touch_in
      expect(loaded_card).to be_in_journey
    end

    it "can touch out" do
      loaded_card.touch_in
      loaded_card.touch_out
      expect(loaded_card).not_to be_in_journey
    end
  end
end