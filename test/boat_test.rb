require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './lib/boat'
require './lib/renter'

class BoatTest < Minitest::Test
  def test_it_exists
    kayak = Boat.new(:kayak, 20)
    assert_instance_of Boat, kayak
  end

  def test_it_has_attributes
    kayak = Boat.new(:kayak, 20)
    assert_equal :kayak, kayak.type
    assert_equal 20, kayak.price_per_hour
  end

  def test_it_starts_with_zero_hours_rented
    kayak = Boat.new(:kayak, 20)
    assert_equal 0, kayak.hours_rented
  end

  def test_it_can_add_hours
    kayak = Boat.new(:kayak, 20)
    kayak.add_hour
    kayak.add_hour
    kayak.add_hour
    assert_equal 3, kayak.hours_rented
  end

  def test_it_starts_not_rented
    kayak = Boat.new(:kayak, 20)
    refute kayak.rented?
  end

  def test_it_can_be_rented
    kayak = Boat.new(:kayak, 20)
    kayak.rent
    assert kayak.rented?
  end

  def test_it_can_be_returned
    kayak = Boat.new(:kayak, 20)
    kayak.rent
    kayak.return
    refute kayak.rented?
  end

  def test_it_has_no_renter_by_default
    kayak = Boat.new(:kayak, 20)

    assert_nil kayak.renter
  end

  def test_it_can_have_renter
    kayak = Boat.new(:kayak, 20)
    renter = Renter.new("Patrick Star", "4242424242424242")
    kayak.add_renter(renter)
    assert_equal renter, kayak.renter
  end

  def test_it_can_release_renter
    kayak = Boat.new(:kayak, 20)
    renter = Renter.new("Patrick Star", "4242424242424242")
    kayak.add_renter(renter)
    kayak.return
    refute kayak.renter
  end

  def test_a_boat_can_charge_a_renter
    kayak = Boat.new(:kayak, 20)
    renter = Renter.new("Patrick Star", "4242424242424242")
    kayak.add_renter(renter)
    kayak.charge_renter(3)
    assert_equal 60, renter.charges
  end
end
