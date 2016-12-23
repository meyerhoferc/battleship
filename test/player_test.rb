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
    coords_1 = "A1"
    coords_2 = "A2"
    coords_3 = "A3"
    coords_4 = "A4"
    coords_5 = "B1"

    assert_equal 0, player.shots
    player.fire(opponent.ship_board, coords_1)
    assert_equal 1, player.shots
    player.fire(opponent.ship_board, coords_2)
    assert_equal 2, player.shots
    player.fire(opponent.ship_board, coords_3)
    assert_equal 3, player.shots
    player.fire(opponent.ship_board, coords_4)
    assert_equal 4, player.shots
    player.fire(opponent.ship_board, coords_5)
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

  def test_when_fires_adds_coords_to_array
    coords = "B3"
    assert_equal [], player.fired_coords
    player.fire(opponent.ship_board, coords)
    assert_equal 1, player.fired_coords.count
  end

  def test_knows_if_has_already_fired_at_a_coordinate
    coord_1 = "A1"
    coord_2 = "B3"
    coord_3 = "D4"
    player.fire(opponent.ship_board, coord_1)
    player.fire(opponent.ship_board, coord_2)
    assert player.fired_already?(coord_1)
    assert player.fired_already?(coord_2)
    refute player.fired_already?(coord_3)
  end

  def test_cannot_fire_if_already_fired_at_coordinate
    coord_1 = "A1"
    coord_2 = "B3"
    coord_3 = "D4"
    assert player.fire(opponent.ship_board, coord_1)
    assert player.fire(opponent.ship_board, coord_2)
    refute player.fire(opponent.ship_board, coord_1)
    refute player.fire(opponent.ship_board, coord_2)
  end

  def test_cannot_fire_if_coordinate_nonsensical
    coord_1 = "Aaaa"
    coord_2 = "B189"
    coord_3 = "D9933jfkdls"
    refute player.fire(opponent.ship_board, coord_1)
    refute player.fire(opponent.ship_board, coord_2)
    refute player.fire(opponent.ship_board, coord_3)
  end

end
