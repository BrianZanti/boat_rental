class Boat
  attr_reader :type,
              :price_per_hour,
              :hours_rented,
              :renter

  def initialize(type, price_per_hour)
    @type = type
    @price_per_hour = price_per_hour
    @hours_rented = 0
    @rented = false
    @renter = nil
  end

  def add_hour
    @hours_rented += 1
  end

  def rent
    @rented = true
  end

  def rented?
    @rented
  end

  def return
    @rented = false
    @renter = nil
  end

  def add_renter(renter)
    @renter = renter
  end

  def charge_renter(hours)
    charge = hours * @price_per_hour
    @renter.add_charge(charge)
  end
end
