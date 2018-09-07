require 'pry'
class Dock
  attr_reader :name,
              :max_rental_time

  def initialize(name, max_rental_time)
    @name = name
    @max_rental_time = max_rental_time
    @rentals = []
    @renters = []
  end

  def rent(boat, renter)
    boat.rent
    boat.add_renter(renter)
    binding.pry
    @rentals << boat
    @renters << renter
  end

  def log_hour
    @rentals.each do |rental|
      rental.add_hour if rental.rented?
    end
  end

  def return(boat)
    if boat.hours_rented > @max_rental_time
      boat.charge_renter(@max_rental_time)
    else
      boat.charge_renter(boat.hours_rented)
    end
    boat.return
  end

  def revenue
    @rentals.map do |rental|
      if rental.hours_rented > @max_rental_time
        rental.price_per_hour * @max_rental_time
      else
        rental.price_per_hour * rental.hours_rented
      end
    end.sum
  end

  def charges
    charges_hash = {}
    @renters.each do |renter|
      charges_hash[renter.credit_card_number] = renter.charges
    end
    charges_hash
  end
end
