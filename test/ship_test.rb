require_relative 'test_helper'
require './lib/ship.rb'

class ShipTest < Minitest::Test
  attr_reader :ship,
              :ship_1,
              :ship_2
  def setup
    @ship = Ship.new(2)
    @ship_1 = Ship.new(2)
    @ship_2 = Ship.new(3)
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

  def test_ship_knows_it_has_been_sunk
    assert_equal 0, ship_1.times_hit
    assert_equal 0, ship_2.times_hit
    ship_1.hit
    ship_2.hit
    refute ship_1.sunk?
    refute ship_2.sunk?
    ship_1.hit
    ship_2.hit
    ship_2.hit
    assert ship_1.sunk?
    assert ship_2.sunk?
  end
end
