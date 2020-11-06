class Oystercard
  attr_reader :balance, :entry_station, :exit_station, :journey_history, :current_journey
  LIMIT = 90
  MINIMUM = 1

  def initialize
    @balance = 0
    @journey_history = []
  end

  def top_up(amount)
    raise "Maximum balance of #{LIMIT} reached" if @balance + amount > LIMIT
    @balance += amount
  end

  def in_journey?
    @entry_station != nil
  end

  def touch_in(station)
    check_for_credit
    @entry_station = station
    @journey_history << Journey.new
    @journey_history.last.entry_station = station
  end

  def touch_out(station)
    deduct
    @journey_history.last.exit_station = station
    @entry_station = nil
  end

  private

  def check_for_credit
    if @balance < MINIMUM
      raise "error"
    end
  end


  def deduct(fare = MINIMUM)
    @balance -= fare
  end

end
