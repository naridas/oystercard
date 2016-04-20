require "oystercard"

describe Oystercard do
  let(:entry_station) { double(:entry_station) }
  let(:exit_station) { double(:exit_station) }

  let(:loaded_card) do
    loaded_card = Oystercard.new
    loaded_card.top_up(Oystercard::MAXIMUM_BALANCE)
    loaded_card
  end
  let(:station) {double (:station)}

  context "when new card issues" do
    it "has initial balance" do
      expect(subject.balance).to eq(0)
    end

    it "journey? is false" do
      expect(subject.in_journey?).to be false
    end

    it "list of journeys is empty" do
      expect(subject.journeys).to be_empty
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
      expect{ subject.touch_in(station) }.to raise_error "Not enough balance on card"
    end
  end

  context "charging the customer" do
    it "deducts minimum fare when touch_out" do
      expect{ loaded_card.touch_out(exit_station) }.to change{ loaded_card.balance }.by -Oystercard::MINIMUM_FARE
    end
  end

  context "add touch_in and out" do
    it "can touch in" do
      loaded_card.touch_in(entry_station)
      expect(loaded_card).to be_in_journey
    end

    it "can touch out" do
      loaded_card.touch_in(entry_station)
      loaded_card.touch_out(exit_station)
      expect(loaded_card).not_to be_in_journey
    end
  end

  context " history journeys " do
    # it 'stores exit station' do
    #   loaded_card.touch_in(entry_station)
    #   loaded_card.touch_out(exit_station)
    #   expect(loaded_card.exit_station).to eq exit_station
    # end

    it "remembers the entry_station when touch in" do
      loaded_card.touch_in(entry_station)
      expect(loaded_card.entry_station).to eq entry_station
    end

    it "forgets the entry station when touch out" do
      loaded_card.touch_in(entry_station)
      loaded_card.touch_out(exit_station)
      expect(loaded_card.entry_station).to be nil
    end
  end

  context "saving previous journeys" do
    let(:test_journey){ {entry_station: entry_station, exit_station: exit_station} }
    before(:each) do
      loaded_card.touch_in(entry_station)
      loaded_card.touch_out(exit_station)
    end

    # it "stores one journey" do
    #   expect(loaded_card.journey.keys).to include :entry_station
    #   expect(loaded_card.journey.values).to include exit_station
    # end

    it "adds the current journey to the journey history" do
      #test_journey = Hash.new
      #test_journey[:entry_station] = exit_station
      expect(loaded_card.journeys.last).to eq test_journey
    end
  end
end