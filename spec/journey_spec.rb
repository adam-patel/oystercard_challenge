require 'journey'
require 'oystercard'

describe Journey do

  let(:station) {double :station}

  it "stores an entry station" do
    subject.entry_station = station
    expect(subject.entry_station).to eq(station)
  end

  it "stores an exit station" do
    subject.exit_station = station
    expect(subject.exit_station).to eq(station)
  end

  it "returns the minimum fare (for the moment)" do
    subject.entry_station = station
    subject.exit_station = station 
    expect(subject.fare).to eq(Oystercard::MINIMUM)
  end

  it "charges a penalty of 6 if entry station is absent" do
    subject.entry_station = nil
    subject.exit_station = station
    expect(subject.fare).to eq(6)
  end

  it "charges a penalty of 6 if exit station is absent" do
    subject.entry_station = station
    subject.exit_station = nil
    expect(subject.fare).to eq(6)
  end


end
