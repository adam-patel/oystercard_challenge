require 'oystercard'

describe Oystercard do

let(:station) {double :station}

  it 'creates an Oystercard instance' do
    expect(subject).to be_instance_of(Oystercard)
  end

  describe '#balance' do
    it 'responds to the method' do
      expect(subject).to respond_to(:balance)
    end

    it 'sets a default balance of 0' do
      expect(subject.balance).to eq(0)
    end

    it "has an empty list of journeys by default(journey_history)" do
      expect(subject.journey_history).to be_instance_of(Array)
    end

  end

  describe '#top_up' do
    it 'responds to the method' do
      expect(subject).to respond_to(:top_up).with(1).argument
    end

    it 'adds amount to balance' do
      expect { subject.top_up(10) }.to change { subject.balance }.from(0).to(10)
    end

    it 'enforces a maximum balance' do
      max_balance = Oystercard::LIMIT
      subject.top_up(max_balance)
      expect { subject.top_up(1) }.to raise_error("Maximum balance of #{max_balance} reached")
    end
  end

  # The deduct class tests no longer work because deduct is now a private method

  # describe '#deduct' do
  #   it 'responds to the method' do
  #     expect(subject).to respond_to(:deduct).with(1).argument
  #   end
  #
  #   it 'deducts fare from balance' do
  #     subject.top_up(10)
  #     expect { subject.deduct(10) }.to change { subject.balance }.by(-10)
  #   end
  # end

  describe "in_journey?" do

    it "responds to the method" do
      expect(subject).to respond_to(:in_journey?)
    end

    it "declares in journey based on presence of entry_station" do
      subject.top_up(10)
      subject.touch_in(station)
      expect(subject).to_not be true
    end

    it "is remembers the entry station" do
      expect(subject.entry_station).to be nil
    end

  end

  describe '#touch_in' do

    it "responds to the method" do
      expect(subject).to respond_to(:touch_in)
    end

    it "checks minimum balance is above £1" do
      @balance = 0.8
      expect{subject.touch_in(station)}.to raise_error "error"
    end
#11
    it "saves the entry station" do
      subject.top_up(10)
      subject.touch_in(station)
      expect(subject.entry_station).to_not be nil
    end

  end

  describe "#touch_out" do

    it "responds to the method" do
      expect(subject).to respond_to(:touch_in)
    end

    it "changes in_journey? to be nil" do
      subject.top_up(10)
      subject.touch_in(station)
      subject.touch_out(station)
      expect(subject.in_journey?).to be false
    end

    it "charges the customer for their journey" do
      subject.top_up(10)
      subject.touch_in(station)
      expect{subject.touch_out(station)}.to change{subject.balance}.by(-1)
    end

    it "@entry_station forgets the entry station at the end of the journey" do
      subject.top_up(10)
      subject.touch_in(station)
      expect{subject.touch_out(station)}.to change {subject.entry_station}.from(station).to(nil)
    end

    # it "stores the exit station in @exit_station" do
    #   subject.top_up(10)
    #   subject.touch_in(station)
    #   subject.touch_out(station)
    #   expect(subject.exit_station).to eq(station)
    # end

    # it "stores one journey" do
    #   subject.top_up(10)
    #   subject.touch_in(station)
    #   subject.touch_out(station)
    #   expect(subject.current_journey).to include(:entry_station)
    # end

    it "puts the journey into the journey_history array" do
      subject.top_up(10)
      subject.touch_in(station)
      subject.touch_out(station)
      expect(subject.journey_history[0].entry_station).to eq(station)
      expect(subject.journey_history[0].exit_station).to eq(station)
    end

  end

  end
