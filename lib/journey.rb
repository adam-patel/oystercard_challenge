class Journey

  attr_accessor :entry_station, :exit_station

  def initialize
    @entry_station = nil
    @exit_station = nil
  end

  def fare
    @entry_station == nil || @exit_station == nil ? 6 : Oystercard::MINIMUM
  end

end
