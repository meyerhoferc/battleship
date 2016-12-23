require './lib/ship.rb'
require './lib/ledger.rb'
require './lib/messages.rb'
require './lib/firing_rules.rb'
require 'pry'

class Player
  include FiringRules
  attr_reader :ship_board,
              :shots_fired,
              :collection,
              :fleet,
              :shots,
              :fired_coords

  def initialize
    @ship_board = Ledger.new
    @shots_fired = Ledger.new
    @collection = [@ship_board, @shots_fired]
    @ship_1 = Ship.new(2)
    @ship_2 = Ship.new(3)
    @fleet = [@ship_1, @ship_2]
    @shots = 0
    @fired_coords = []
  end

  def place_ship(ship, coords, board = @ship_board)
    board.insert(ship, coords)
  end

  def fire(board, coords)
    valid_firing_coords?(coords) ? @shots += 1 : false
  end

  def valid_firing_coords?(coords)
    if fired_already?(coords) || FiringRules.coords_exist?(coords) == false
      false
    else
      @fired_coords << coords
    end
  end

  def all_ships_sunk?
    @ship_1.sunk? && @ship_2.sunk? ? true : false
  end

  def fired_already?(coord)
    @fired_coords.include?(coord)
  end
end
