require './lib/ship.rb'
require './lib/ledger.rb'
require './lib/messages.rb'
require 'pry'

class Opponent
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
    @possible_ship_placements = []
    @possible_firing_locations = []
    update_possible_firing_locations
    # place_ships_on_board
  end

  def update_possible_firing_locations
    @possible_firing_locations = ["A1", "A2", "A3", "A4",
                        "B1", "B2", "B3", "B4",
                        "C1", "C2", "C3", "C4",
                        "D1", "D2", "D3", "D4"]
  end

  def pick_orientation
    orientations = ['horizontal', 'vertical']
    orientations.shuffle.first
  end

  def pick_first_coordinate
    @possible_firing_locations.shuffle.first
  end

  def pick_coordinate_set(ship)
    orientation = pick_orientation
    coord_1 = pick_first_coordinate
    if ship.size == 2
      get_adjacent_coordinate(coord_1, orientation)
    else
      get_size_three_coordinate(coords_1, orientation)
    end
  end

  def get_adjacent_coordinate(coord, orientation)
    @coord_1 = coord
    row_1, column_1 = coord.chars
    if orientation == 'horizontal' && column_1.to_i < 4
      coord_2_index = @possible_firing_locations.index(coord) + 1
      @coord_2 = @possible_firing_locations[coord_2_index]
    elsif orientation == 'horizontal' && column_1.to_i == 4
      coord_2_index = @possible_firing_locations.index(coord) - 1
      @coord_2 = @possible_firing_locations[coord_2_index]
    elsif orientation == 'vertical' && row_1 == 'A'
      coord_2_index = @possible_firing_locations.index(coord) + 4
      @coord_2 = @possible_firing_locations[coord_2_index]
    elsif orientation == 'vertical' && row_1 == 'D'
      coord_2_index = @possible_firing_locations.index(coord) - 4
      @coord_2 = @possible_firing_locations[coord_2_index]
    elsif orientation == 'vertical'
      coord_2_index = @possible_firing_locations.index(coord) + 4
      @coord_2 = @possible_firing_locations[coord_2_index]
    else
      #nothing else here
    end
  end


  def get_size_three_coordinate(coords_1, orientation)
  end

  def place_ships_on_board(board = @ship_board)
    @fleet.each do |ship|
      pick_coordinate_set
      coords = @coord_1 + " " + @coord_2
      board.insert(ship, coords)
    end
  end
end
