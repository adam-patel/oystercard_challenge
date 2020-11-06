require 'station'

describe Station do

  # it "exists" do
  #   expect(subject).to be_instance_of(Station)
  # end

  it "knows its name" do
    expect(Station.new("name", 1).name).to eq("name")
  end

  it "knows its own zone" do
    expect(Station.new("name", 1).zone).to eq(1)
  end

end
