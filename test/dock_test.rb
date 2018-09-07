require 'minitest/autorun'
require 'minitest/pride'
require './lib/dock'
require './lib/boat'
require './lib/renter'

class DockTest < Minitest::Test
  def test_it_exists
    dock = Dock.new("The Rowing Dock", 3)
    assert_instance_of Dock, dock
  end

  def test_it_has_attributes
    dock = Dock.new("The Rowing Dock", 3)
    assert_equal "The Rowing Dock", dock.name
    assert_equal 3, dock.max_rental_time
  end

  def test_it_can_calculate_revenue_for_an_hour
    dock = Dock.new("The Rowing Dock", 3)
    kayak_1 = Boat.new(:kayak, 20)
    patrick = Renter.new("Patrick Star", "4242424242424242")
    dock.rent(kayak_1, patrick)
    dock.log_hour
    dock.return(kayak_1)

    assert_equal 20, dock.revenue
  end

  def test_it_doesnt_charge_more_than_max_rental_time
    dock = Dock.new("The Rowing Dock", 3)
    kayak_1 = Boat.new(:kayak, 20)
    patrick = Renter.new("Patrick Star", "4242424242424242")
    dock.rent(kayak_1, patrick)
    dock.log_hour
    dock.log_hour
    dock.log_hour
    dock.log_hour
    dock.return(kayak_1)

    assert_equal 60, dock.revenue
  end

  def test_it_can_rent_multiple_boats
    dock = Dock.new("The Rowing Dock", 3)
    kayak_1 = Boat.new(:kayak, 20)
    kayak_2 = Boat.new(:kayak, 20)
    canoe = Boat.new(:canoe, 30)
    sup_1 = Boat.new(:standup_paddle_board, 15)
    sup_2 = Boat.new(:standup_paddle_board, 15)
    patrick = Renter.new("Patrick Star", "4242424242424242")
    eugene = Renter.new("Eugene Crabs", "1313131313131313")

    # Rent Boats out to first Renter
    dock.rent(kayak_1, patrick)
    dock.rent(kayak_2, patrick)
    dock.log_hour
    dock.rent(canoe, patrick)
    dock.log_hour
    dock.return(kayak_1)
    dock.return(kayak_2)
    dock.return(canoe)

    # Rent Boats out to second Renter
    dock.rent(sup_1, eugene)
    dock.rent(sup_2, eugene)
    dock.log_hour
    dock.log_hour
    dock.log_hour

    # Any hours rented past the max rental time are not counted
    dock.log_hour
    dock.log_hour
    dock.return(sup_1)
    dock.return(sup_2)

    # Total revenue
    assert_equal 200, dock.revenue
  end

  def test_it_can_track_charges
    dock = Dock.new("The Rowing Dock", 3)
    kayak_1 = Boat.new(:kayak, 20)
    kayak_2 = Boat.new(:kayak, 20)
    canoe = Boat.new(:canoe, 30)
    sup_1 = Boat.new(:standup_paddle_board, 15)
    sup_2 = Boat.new(:standup_paddle_board, 15)
    patrick = Renter.new("Patrick Star", "4242424242424242")
    eugene = Renter.new("Eugene Crabs", "1313131313131313")

    # Rent Boats out to first Renter
    dock.rent(kayak_1, patrick)
    dock.rent(kayak_2, patrick)
    dock.log_hour
    dock.rent(canoe, patrick)
    dock.log_hour
    dock.return(kayak_1)
    dock.return(kayak_2)
    dock.return(canoe)

    # Rent Boats out to second Renter
    dock.rent(sup_1, eugene)
    dock.rent(sup_2, eugene)
    dock.log_hour
    dock.log_hour
    dock.log_hour

    # Any hours rented past the max rental time are not counted
    dock.log_hour
    dock.log_hour
    dock.return(sup_1)
    dock.return(sup_2)

    # Total revenue
    expected = {
      "4242424242424242" => 110,
      "1313131313131313" => 90
    }
    assert_equal expected, dock.charges
  end
end
