require_relative 'test_helper'
require './lib/ledger.rb'
require './lib/ship.rb'
require './lib/coordinate_rules.rb'
require 'pry'

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

  def test_it_knows_if_coords_not_empty
    coords_1 = "A1 B1"
    coords_2 = "B3 D3"
    ledger_2 = Ledger.new
    ledger_2.board["A"][0] = ship_1
    ledger_2.board["B"][0] = ship_1
    ledger_2.board["B"][2] = ship_2
    ledger_2.board["D"][2] = ship_2

    refute CoordinateRules.coords_empty?(ledger_2, coords_1)
    refute CoordinateRules.coords_empty?(ledger_2, coords_2)
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

  def test_middle_coordinate_available_for_size_3_vertical_ship
    coords = "B3 D3"
    assert CoordinateRules.all_three_empty?(ledger, coords)
    ledger.board["B"][2] = ship_2
    ledger.board["C"][2] = ship_2
    ledger.board["D"][2] = ship_2
    refute  CoordinateRules.all_three_empty?(ledger, coords)
  end

  def test_middle_coordinate_available_for_size_3_horizontal_ship
    coords = "A1 A3"
    assert CoordinateRules.all_three_empty?(ledger, coords)
    ledger.board["A"][0] = ship_2
    ledger.board["A"][1] = ship_2
    ledger.board["A"][2] = ship_2
    refute  CoordinateRules.all_three_empty?(ledger, coords)
  end
end
