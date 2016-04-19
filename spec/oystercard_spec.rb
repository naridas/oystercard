require "oystercard"

describe Oystercard do
  let(:entry_station) { double(:entry_station) }

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
      expect{ subject.touch_in(entry_station)}.to raise_error "Not enough balance on card"
    end
  end

  context "charging the customer" do
    it "deducts minimum fare when touch_out" do
      expect{ loaded_card.touch_out }.to change{ loaded_card.balance }.by -Oystercard::MINIMUM_FARE
    end
  end

  context "add touch_in and out" do
    it "can touch in" do
      loaded_card.touch_in(entry_station)
      expect(loaded_card).to be_in_journey
    end

    it "can touch out" do
      loaded_card.touch_in(entry_station)
      loaded_card.touch_out
      expect(loaded_card).not_to be_in_journey
    end
  end

  context " history journeys " do
    it "remembers the entry_station when touch in" do
      loaded_card.touch_in(entry_station)
      expect(loaded_card.entry_station).to eq entry_station
    end

    it "forgets the entry station when touch out" do
      loaded_card.touch_in(entry_station)
      loaded_card.touch_out
      expect(loaded_card.entry_station).to be nil
    end
  end
end


 # Write a test that expects the card to remember the entry station after the touch in
 # Update the touch_in method to accept the entry station using a double
 # Update existing tests to pass a station to the touch_in method - you may need to declare your double in a let statement at the top of your describe block
 # Expose entry_station instance variable using an attribute reader
 # Make the card forget the entry station on touch out by setting it to nil
 # When your tests are all green, refactor to remove the in_journey variable. Rewrite the in_journey? method to infer its status based on whether or not there is an entry station