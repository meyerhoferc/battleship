require_relative 'test_helper'
require './lib/ledger.rb'
require './lib/ship.rb'
require './lib/player.rb'
require './lib/opponent.rb'

class PlayerTest < Minitest::Test
  attr_reader :player,
              :ship_board,
              :shots_fired,
              :opponent
  def setup
    @player = Player.new
    @ship_board = Ledger.new
    @shots_fired = Ledger.new
    @opponent = Opponent.new
  end

  def test_it_is_a_player
    assert player
    assert_equal Player, player.class
  end

  def test_player_has_two_boards
    assert_equal 2, player.collection.count
    assert_equal Ledger, player.collection[0].class
    assert_equal Ledger, player.collection[1].class
  end

  def test_player_has_ship_fleet
    assert player.fleet
    assert_equal 2, player.fleet.count
    assert_equal Ship, player.fleet[0].class
    assert_equal Ship, player.fleet[1].class
    assert_equal 2, player.fleet[0].size
    assert_equal 3, player.fleet[1].size
  end

  def test_can_input_ship_onto_board
    coords = "A1 A2"
    refute player.ship_board.has_ship?(player.fleet[0])
    player.place_ship(player.fleet[0], coords)
    assert player.ship_board.has_ship?(player.fleet[0])
  end

  def test_can_input_two_ships_onto_board
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
    refute player.fleet[0].placed?
    refute player.fleet[1].placed?
  end

  def test_has_no_shots_fired_by_default
    assert_equal 0, player.shots
  end

  def test_shots_increases_when_firing
    coords = "A1"
    player.fire(opponent.ship_board, coords)
    assert_equal 1, player.shots
    player.fire(opponent.ship_board, coords)
    assert_equal 2, player.shots
    player.fire(opponent.ship_board, coords)
    assert_equal 3, player.shots
    player.fire(opponent.ship_board, coords)
    assert_equal 4, player.shots
    player.fire(opponent.ship_board, coords)
    assert_equal 5, player.shots
  end


  def test_knows_if_all_ships_sunk
    coord_1 = "A1 A2"
    coord_2 = "D1 B1"
    ship_1 = player.fleet[0]
    ship_2 = player.fleet[1]
    player.place_ship(ship_1, coord_1)
    player.place_ship(ship_2, coord_2)

    refute player.all_ships_sunk?
    ship_1.hit
    ship_1.hit
    ship_2.hit
    ship_2.hit
    ship_2.hit
    assert player.all_ships_sunk?
  end


  def test_can_make_a_shot_at_opponent
    coords = "C2"
    assert player.fire(opponent.ship_board, coords)
  end


end
