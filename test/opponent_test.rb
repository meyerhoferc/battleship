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

  def test_keeps_track_of_shots_made_at_enemy
    assert_equal 0, opponent.shots
    opponent.fire
    assert_equal 1, opponent.shots
    opponent.fire
    assert_equal 2, opponent.shots
    opponent.fire
    assert_equal 3, opponent.shots
  end

  def test_can_make_a_shot_at_enemy
    coords = "C2"
    assert opponent.fire
  end

  def test_inserts_ships_on_board
    ship_1 = opponent.fleet[0]
    ship_2 = opponent.fleet[1]

    assert_equal 2, ship_1.size
    assert_equal 3, ship_2.size

    refute ship_1.placed?
    refute ship_2.placed?

    opponent.place_ships_on_board
    assert opponent.ship_board.has_ship?(ship_1)
    assert opponent.ship_board.has_ship?(ship_2)

    assert ship_1.placed?
    assert ship_2.placed?
  end

  def test_knows_if_all_ships_sunk
    ship_1 = opponent.fleet[0]
    ship_2 = opponent.fleet[1]
    refute opponent.all_ships_sunk?
    ship_1.hit
    ship_1.hit
    assert ship_1.sunk?
    ship_2.hit
    ship_2.hit
    refute ship_2.sunk?
    refute opponent.all_ships_sunk?
    ship_2.hit
    assert opponent.all_ships_sunk?
  end
end
