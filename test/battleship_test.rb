require_relative 'test_helper'
require './lib/ledger.rb'
require './lib/ship.rb'
require './lib/player.rb'
require './lib/opponent.rb'
require './lib/battleship.rb'

class BattleshipTest < Minitest::Test
  attr_reader :battleship
  def setup
    @battleship = BattleShip.new
  end

  def test_it_exists
    assert battleship
  end

  def test_it_has_an_opponent
    assert battleship.opponent
    assert_equal Opponent, battleship.opponent.class
  end

  def test_it_has_a_player
    assert battleship.player
    assert_equal Player, battleship.player.class
  end
end
