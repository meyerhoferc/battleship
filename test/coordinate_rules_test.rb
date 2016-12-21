require_relative 'test_helper'
require './lib/ledger.rb'
require './lib/ship.rb'
require './lib/coordinate_rules.rb'

class CoordinateRulesTest < Minitest::Test
  include CoordinateRules
  attr_reader :ledger,
              :ship_1,
              :ship_2
  def setup
    @ledger = Ledger.new
    @ship_1 = Ship.new(2)
    @ship_2 = Ship.new(3)
  end

  def test_knows_if_coords_exist_in_ledger
    coords = "B1 B2"
    formatted_coords = ledger.format_pairs(coords)
    assert CoordinateRules.coords_exist?(ledger, formatted_coords)
  end

  def test_knows_coords_do_not_exist
    coords = "E8 B9"
    formatted_coords = ledger.format_pairs(coords)
    refute CoordinateRules.coords_exist?(ledger, formatted_coords)
  end

  def test_knows_if_coords_are_vertical
    skip
    coords = "A1 A2"
    formatted_coords = ledger.format_pairs(coords)
    refute ledger.vertical_coords?(formatted_coords)
    assert ledger.horizontal_coords?(formatted_coords)
  end

  def test_knows_if_coords_are_horizontal
    skip
    coords = "A1 B1"
    formatted_coords = ledger.format_pairs(coords)
    assert ledger.vertical_coords?(formatted_coords)
    refute ledger.horizontal_coords?(formatted_coords)
  end

  def test_it_knows_if_coords_match_ship_size
    coords_1 = "A1 B1"
    coords_2 = "A2 B2"
    coords_3 = "A1 C1"
    coords_4 = "A2 D2"
    formatted_coords_1 = ledger.format_pairs(coords_1)
    formatted_coords_2 = ledger.format_pairs(coords_2)
    formatted_coords_3 = ledger.format_pairs(coords_3)
    formatted_coords_4 = ledger.format_pairs(coords_4)

    assert CoordinateRules.ship_length_equals_coord_length(ship_1, formatted_coords_1)
    assert CoordinateRules.ship_length_equals_coord_length(ship_1, formatted_coords_2)
    refute CoordinateRules.ship_length_equals_coord_length(ship_1, formatted_coords_3)
    refute CoordinateRules.ship_length_equals_coord_length(ship_1, formatted_coords_4)

    refute CoordinateRules.ship_length_equals_coord_length(ship_2, formatted_coords_1)
    refute CoordinateRules.ship_length_equals_coord_length(ship_2, formatted_coords_2)
    assert CoordinateRules.ship_length_equals_coord_length(ship_2, formatted_coords_3)
    refute CoordinateRules.ship_length_equals_coord_length(ship_2, formatted_coords_4)
  end

  def test_it_knows_if_coords_are_empty
    coords_1 = "A1 B1"
    coords_2 = "A2 B2"
    coords_3 = "A1 C1"
    assert CoordinateRules.coords_empty?(ledger, coords_1)
    assert CoordinateRules.coords_empty?(ledger, coords_2)
    assert CoordinateRules.coords_empty?(ledger, coords_3)
  end

  def test_knows_if_coords_are_adjacent
    coords_1 = "A1 B1"
    coords_2 = "A2 B2"
    coords_3 = "A1 B2"
    coords_4 = "D4 B2"

    assert CoordinateRules.coordinates_adjacent?(ledger, coords_1)
    assert CoordinateRules.coordinates_adjacent?(ledger, coords_2)
    refute CoordinateRules.coordinates_adjacent?(ledger, coords_3)
    refute CoordinateRules.coordinates_adjacent?(ledger, coords_4)

  end

  def test_can_insert_a_ship_with_valid_coordinates
    skip

    refute ledger.has_ship?(ship_1)
    refute ledger.has_ship?(ship_2)

    ledger.insert(ship_1, coord_1)
    ledger.insert(ship_2, coord_2)

    assert ledger.has_ship?(ship_1)
    assert ledger.has_ship?(ship_2)
  end

  def test_it_knows_if_coords_not_empty
    skip
  end

  def test_can_not_insert_a_ship_with_invalid_coordinates
    skip
  end

  def test_insertion_coordinates_must_be_adjacent
    skip
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
