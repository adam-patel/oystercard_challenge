require 'oystercard'

describe Oystercard do
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

  describe '#deduct' do
    it 'responds to the method' do
      expect(subject).to respond_to(:deduct).with(1).argument
    end

    it 'deducts fare from balance' do
      subject.top_up(10)
      expect { subject.deduct(10) }.to change { subject.balance }.by(-10)
    end
  end

  describe "in_journey?" do

    it "responds to the method" do
      expect(subject).to respond_to(:in_journey?)
    end

    it "changes status of @in_journey when called" do
      expect(subject.in_journey?).to be true | false
    end

    it "is initially not in a journey" do
      expect(subject.in_journey).to be false
    end

  end

  describe '#touch_in' do

    it "responds to the method" do
      expect(subject).to respond_to(:touch_in)
    end

    it "changes @in_journey to true" do
      subject.top_up(10)
      subject.touch_in
      expect(subject.in_journey).to be true
    end

    it "checks minimum balance is above £1" do
      @balance = 0.8
      expect{subject.touch_in}.to raise_error "error"
    end

  end

  describe "#touch_out" do

    it "responnds to the method" do
      expect(subject).to respond_to(:touch_in)
    end

    it "changes @in_journey to false" do
      subject.top_up(10)
      subject.touch_in
      subject.touch_out
      expect(subject.in_journey).to be false
    end

    it "charges the customer for their journey" do
      subject.top_up(10)
      subject.touch_in
      expect{subject.touch_out}.to change{subject.balance}.by(-1)
    end

  end



  end
