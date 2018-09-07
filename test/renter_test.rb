require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './lib/renter'

class RenterTest < Minitest::Test
  def test_it_exists
    renter = Renter.new("Patrick Star", "4242424242424242")
    assert_instance_of Renter, renter
  end

  def test_it_has_attributes
    renter = Renter.new("Patrick Star", "4242424242424242")
    assert_equal "Patrick Star", renter.name
    assert_equal "4242424242424242", renter.credit_card_number
  end

  def test_it_starts_with_no_charges
    renter = Renter.new("Patrick Star", "4242424242424242")
    assert_equal 0, renter.charges
  end

  def test_it_can_add_charges
    renter = Renter.new("Patrick Star", "4242424242424242")
    renter.add_charge(125)
    renter.add_charge(75)
    assert_equal 200, renter.charges
  end
end
