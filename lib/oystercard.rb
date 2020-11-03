class Oystercard
  attr_reader :balance, :in_journey
  LIMIT = 90
  MINIMUM = 1

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    raise "Maximum balance of #{LIMIT} reached" if @balance + amount > LIMIT
    @balance += amount
  end

  def deduct(fare = 1)
    @balance -= fare
  end

  def in_journey?
    @in_journey = !@in_journey
  end

  def touch_in
    if @balance < MINIMUM
      raise "error"
    end
    in_journey?
  end

  def touch_out
    deduct
    in_journey?
  end

end
