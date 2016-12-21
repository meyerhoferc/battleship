require_relative 'test_helper'
require './lib/ship.rb'

class ShipTest < Minitest::Test
  attr_reader :ship
  def setup
    @ship = Ship.new(2)
  end

  def test_ship_exists
    assert ship
  end

  def test_ship_can_have_length_of_two
    assert_equal 2, ship.size
  end

  def test_ship_can_have_length_of_three
    ship_2 = Ship.new(3)
    assert_equal 3, ship_2.size
  end

  def test_ship_knows_if_it_has_not_been_placed_on_board
    refute ship.placed?
  end

  def test_ship_knows_if_it_has_been_placed_on_board
    ship.place_on_board
    assert ship.placed?
  end

  def test_ship_not_hit_by_default
    assert_equal 0, ship.times_hit
  end

  def test_ship_knows_it_has_been_hit
    assert_equal 0, ship.times_hit
    ship.hit
    assert_equal 1, ship.times_hit
  end

end
