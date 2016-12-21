require './lib/ship.rb'
require './lib/ledger.rb'
require './lib/messages.rb'
require 'pry'

class Player
  attr_reader :ship_board,
              :shots_fired,
              :collection,
              :fleet,
              :shots
  def initialize
    @ship_board = Ledger.new
    @shots_fired = Ledger.new
    @collection = [@ship_board, @shots_fired]
    @ship_1 = Ship.new(2)
    @ship_2 = Ship.new(3)
    @fleet = [@ship_1, @ship_2]
    @shots = 0
  end

  def place_ship(ship, coords, board = @ship_board)
    board.insert(ship, coords)
  end

  def fire(coords)
    @shots += 1
    # talks to opponent board
    # will show out shots fired
  end
end
