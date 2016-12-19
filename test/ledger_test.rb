require_relative 'test_helper'
require './lib/ledger.rb'
require './lib/ship.rb'

class LedgerTest < Minitest::Test
  attr_reader :ledger,
              :ship_1,
              :ship_2
  def setup
    @ledger = Ledger.new
    @ship_1 = Ship.new(2)
    @ship_2 = Ship.new(3)
  end

  def test_it_is_a_ledger
    assert ledger
    assert_equal Ledger, ledger.class
  end

  def test_difficulty_1_by_default
    assert_equal 1, ledger.difficulty
  end

  def test_its_nil_by_default
    assert_equal ledger.board['.'], ['1', '2', '3', '4']
    assert_nil ledger.board['A'][2]
    assert_nil ledger.board['B'][2]
    assert_nil ledger.board['C'][2]
    assert_nil ledger.board['D'][2]
  end

  def test_knows_size_of_ship
    assert_equal 2, ship_1.size
    assert_equal 3, ship_2.size
  end

  def test_it_knows_it_does_not_have_a_ship
    refute ledger.has_ship?(ship_1)
    refute ledger.has_ship?(ship_2)
  end

  def test_formats_coords
    coords = "A1 A2"
    formatted_coords = ["A", "1", " ", "A", "2"]
    assert_equal formatted_coords, ledger.format_coords("A1 A2")
  end

  def test_it_knows_if_coords_are_valid
    skip
  end

  def test_it_knows_if_coords_are_empty
    skip
  end

  def test_it_knows_if_coords_not_empty
    skip
  end

  def test_can_insert_a_ship
    skip
    ship_1 = Ship.new(2)
    ship_2 = Ship.new(3)

    refute ledger.has_ship?(ship_1)
    refute ledger.has_ship?(ship_2)

    ledger.insert(ship_1, coord_1)
    ledger.insert(ship_2, coord_2)
  end

  def test_it_knows_it_does_have_a_ship
    skip
  end

  def test_it_knows_if_ship_is_not_hit
    skip
  end

  def test_it_knows_if_ship_is_hit
    skip
  end

end
