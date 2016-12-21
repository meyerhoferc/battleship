require_relative 'test_helper'
require './lib/ledger.rb'
require './lib/ship.rb'
require './lib/opponent.rb'
require 'pry'

class OpponentTest < Minitest::Test
  attr_reader :opponent,
              :ship_board,
              :shots_fired
  def setup
    @opponent = Opponent.new
    @ship_board = Ledger.new
    @shots_fired = Ledger.new
  end

  def test_it_is_an_opponent
    assert opponent
    assert_equal Opponent, opponent.class
  end

  def test_opponent_has_two_boards
    assert_equal 2, opponent.collection.count
    assert_equal Ledger, opponent.collection[0].class
    assert_equal Ledger, opponent.collection[1].class
  end

  def test_opponent_has_ship_fleet
    assert opponent.fleet
    assert_equal 2, opponent.fleet.count
    assert_equal Ship, opponent.fleet[0].class
    assert_equal Ship, opponent.fleet[1].class
    assert_equal 2, opponent.fleet[0].size
    assert_equal 3, opponent.fleet[1].size
  end

  def test_places_ship_randomly_on_board_when_initialized
    skip 
    refute opponent.ship_board.has_ship?(opponent.fleet[0])
    opponent.place_ship(opponent.fleet[0], coords)
    assert opponent.ship_board.has_ship?(opponent.fleet[0])
  end

  def test_can_input_two_ships_onto_board
    skip
    coords_1 = "B2 B3"
    coords_2 = "D1 B1"
    ship_1 = player.fleet[0]
    ship_2 = player.fleet[1]
    refute player.ship_board.has_ship?(ship_1)
    refute player.ship_board.has_ship?(ship_2)
    player.place_ship(ship_1, coords_1)
    player.place_ship(ship_2, coords_2)
    assert player.ship_board.has_ship?(ship_1)
    assert player.ship_board.has_ship?(ship_2)
  end

  def test_knows_if_ships_have_been_placed
    skip
    coords_1 = "B2 B3"
    coords_2 = "D1 B1"
    ship_1 = player.fleet[0]
    ship_2 = player.fleet[1]
    player.place_ship(ship_1, coords_1)
    player.place_ship(ship_2, coords_2)
    assert player.fleet[0].placed?
    assert player.fleet[1].placed?
  end

  def test_knows_if_ships_not_placed
    skip
    refute player.fleet[0].placed?
    refute player.fleet[1].placed?
  end

  def test_can_make_a_shot_at_enemy
    skip
    coords = "C2"
    assert player.fire(coords)
  end


end
