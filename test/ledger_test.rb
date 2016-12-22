require_relative 'test_helper'
require './lib/ledger.rb'
require './lib/ship.rb'
require './lib/coordinate_rules.rb'

class LedgerTest < Minitest::Test
  include CoordinateRules
  attr_reader :ledger,
              :ship_1,
              :ship_2,
              :ship_3
  def setup
    @ledger = Ledger.new
    @ship_1 = Ship.new(2)
    @ship_2 = Ship.new(3)
    @ship_3 = Ship.new(3)
  end

  def test_it_is_a_ledger
    assert ledger
    assert_equal Ledger, ledger.class
  end

  def test_difficulty_1_by_default
    assert_equal 1, ledger.difficulty
  end

  def test_rows_zero_by_default
    assert_equal ledger.board['.'], ['1', '2', '3', '4']
    assert_equal 0, ledger.board['A'][0]
    assert_equal 0, ledger.board['B'][1]
    assert_equal 0, ledger.board['C'][2]
    assert_equal 0, ledger.board['D'][3]
  end

  def test_knows_size_of_ship
    assert_equal 2, ship_1.size
    assert_equal 3, ship_2.size
  end

  def test_it_knows_it_does_not_have_a_ship
    refute ledger.has_ship?(ship_1)
    refute ledger.has_ship?(ship_2)
  end

  def test_it_knows_it_does_have_a_ship
    skip
  end

  def test_formats_coords
    coords = "A1 A2"
    formatted_coords = ["A", "1", " ", "A", "2"]
    assert_equal formatted_coords, ledger.format_letters("A1 A2")
  end

  def test_can_insert_a_ship_with_valid_coordinates
    coord_1 = "A1 A2"
    coord_2 = "B1 B3"
    coord_3 = "D1 B1"

    refute ledger.has_ship?(ship_1)
    refute ledger.has_ship?(ship_2)
    refute ledger.has_ship?(ship_3)
    refute ship_1.placed?
    refute ship_2.placed?
    refute ship_3.placed?

    ledger.insert(ship_1, coord_1)
    ledger.insert(ship_2, coord_2)
    ledger.insert(ship_3, coord_3)
    assert ship_1.placed?
    assert ship_2.placed?
    assert ship_3.placed?

    assert ledger.has_ship?(ship_1)
    assert ledger.has_ship?(ship_2)
    assert ledger.has_ship?(ship_3)
  end

  def test_cannot_insert_a_ship_with_invalid_coords
    skip
    coord_1 = "A1 A4"
    coord_2 = "B1 D3"
    coord_3 = "D1 F1"

    refute ledger.has_ship?(ship_1)
    refute ledger.has_ship?(ship_2)
    refute ledger.has_ship?(ship_3)
    refute ship_1.placed?
    refute ship_2.placed?
    refute ship_3.placed?

    ledger.insert(ship_1, coord_1)
    ledger.insert(ship_2, coord_2)
    ledger.insert(ship_3, coord_3)
    refute ship_1.placed?
    refute ship_2.placed?
    refute ship_3.placed?

    refute ledger.has_ship?(ship_1)
    refute ledger.has_ship?(ship_2)
    refute ledger.has_ship?(ship_3)
  end

  def test_can_print_empty_board
    board = """
    ============
    . 1 2 3 4
    A
    B
    C
    D
    ============
    """
    assert_equal board, ledger.print_board
  end


  def test_it_knows_if_ship_is_not_hit
    # not sure if this belongs here
    coord_1 = "A1 A2"
    coord_2 = "B1 B3"
    coord_3 = "D1 B1"
    ledger.insert(ship_1, coord_1)
    ledger.insert(ship_2, coord_2)
    ledger.insert(ship_3, coord_3)
    assert ship_1.placed?
    assert ship_2.placed?
    assert ship_3.placed?
    refute ships.hit?
    # FINISH HERE
  end

  def test_it_knows_if_ship_is_hit
    skip
  end

  def test_can_print_board_with_hits_and_misses
    skip
  end
end
