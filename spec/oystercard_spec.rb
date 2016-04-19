require "oystercard"

describe Oystercard do
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

  context "#deduct" do
    it "deducts the fare from the card" do
      subject.top_up(30)
      expect{ subject.deduct 10 }.to change{ subject.balance }.by -10
    end
  end

  context "add touch_in and out" do
    it "can touch in" do
      subject.touch_in
      expect(subject).to be_in_journey
      #expect(subject.in_journey?).to be true
    end

    it "can touch out" do
      subject.touch_in
      subject.touch_out
      expect(subject).not_to be_in_journey
      #expect(subject.in_journey?).to be false
    end
  end



end
#To close this issue, you"ll need to test-drive three methods: touch_in, touch_out and in_journey?. Don"t try to write all tests in one go: consider the test that you can write first that will rely on only one method and then write more complex tests.