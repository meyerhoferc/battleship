require './lib/ship.rb'
require './lib/ledger.rb'
require './lib/messages.rb'
require './lib/coordinate_rules.rb'
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
    @possible_firing_locations = []
    @current_ship_placements = []
    @currently_used_coordinates = []
    @shots = 0
    update_possible_firing_locations
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
    @coord_1 = pick_first_coordinate
    if ship.size == 2
      get_adjacent_coordinate(@coord_1, orientation)
    else
      check_for_duplicates(@coord_1) ? pick_coordinate_set(ship) : true
      check_size_three_coordinate(@coord_1, orientation)
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
    end
  end

  def check_for_duplicates(coord)
    @currently_used_coordinates.include?(coord) ? true : false
  end

  def check_size_three_coordinate(coord_1, orientation)
    row_1, column_1 = coord_1.chars
    ship_1_row_1, ship_1_column_1, space, ship_1_row_2, ship_1_column_2 = @current_ship_placements[0].chars
    if (row_1 == ship_1_row_1 && column_1 == ship_1_column_1) ||
      (row_1 == ship_1_row_2 && column_1 == ship_1_column_2)
      pick_coordinate_set(@ship_2)
    else
      get_size_three_coordinate(coord_1, orientation)
    end
  end

  def get_size_three_coordinate(coord_1, orientation)
    if orientation == 'vertical'
      grab_vertical_coordinates(coord_1)
    else
      grab_horizontal_coordinates(coord_1)
    end
  end

  def grab_vertical_coordinates(coord_1)
    row_1, column_1 = coord_1.chars
    if row_1 == "A"
      coord_1_index = @possible_firing_locations.index(coord_1)
      coord_2 = @possible_firing_locations[coord_1_index + 8]
      check_for_duplicates(coord_2) ? pick_coordinate_set(@ship_2) : @coord_2 = coord_2
    elsif row_1 == "D"
      coord_1_index = @possible_firing_locations.index(coord_1)
      coord_2 = @possible_firing_locations[coord_1_index - 8]
      check_for_duplicates(coord_2) ? pick_coordinate_set(@ship_2) : @coord_2 = coord_2
    else
      coord_1_index = @possible_firing_locations.index(coord_1)
      coord_1_new = @possible_firing_locations[coord_1_index - 4]
      check_for_duplicates(coord_1_new) ? pick_coordinate_set(@ship_2) : @coord_1 = coord_1_new
      coord_2_new = @possible_firing_locations[coord_1_index + 4]
      check_for_duplicates(coord_2_new) ? pick_coordinate_set(@ship_2) : @coord_2 = coord_2_new
    end
  end

  def grab_horizontal_coordinates(coord_1)
    row_1, column_1 = coord_1.chars
    if column_1 == "1"
      coord_1_index = @possible_firing_locations.index(coord_1)
      coord_2 = @possible_firing_locations[coord_1_index + 2]
      check_for_duplicates(coord_2) ? pick_coordinate_set(@ship_2) : @coord_2 = coord_2
    elsif column_1 == "4"
      coord_1_index = @possible_firing_locations.index(coord_1)
      coord_2 = @possible_firing_locations[coord_1_index - 2]
      check_for_duplicates(coord_2) ? pick_coordinate_set(@ship_2) : @coord_2 = coord_2
    else
      coord_1_index = @possible_firing_locations.index(coord_1)
      coord_1_new = @possible_firing_locations[coord_1_index - 1]
      check_for_duplicates(coord_1_new) ? pick_coordinate_set(@ship_2) : @coord_1 = coord_1_new
      coord_2_new = @possible_firing_locations[coord_1_index + 1]
      check_for_duplicates(coord_2_new) ? pick_coordinate_set(@ship_2) : @coord_2 = coord_2_new
    end
  end

  def place_ships_on_board(board = @ship_board)
    @fleet.each do |ship|
      pick_coordinate_set(ship)
      coords = @coord_1 + " " + @coord_2
      @currently_used_coordinates << @coord_1
      @currently_used_coordinates << @coord_2
      @current_ship_placements << coords
      board.insert(ship, coords)
    end
  end

  def fire
    @shots += 1
    coords = choose_firing_coordinates
  end

  def choose_firing_coordinates
    @possible_firing_locations.shuffle.shift
  end

  def all_ships_sunk?
    @ship_1.sunk? && @ship_2.sunk? ? true : false
  end
end
