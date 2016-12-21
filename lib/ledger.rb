require './lib/ship.rb'
require './lib/messages.rb'
# require './lib/coordinate_rules.rb'
require 'pry'

class Ledger
  attr_reader :difficulty,
              :board

  def initialize(difficulty = 1)
    @difficulty = difficulty
    @board = Hash.new
    @board['.'] = ['1', '2', '3', '4']
    @board['A'] = Array.new(4, 0)
    @board['B'] = Array.new(4, 0)
    @board['C'] = Array.new(4, 0)
    @board['D'] = Array.new(4, 0)
  end

  def has_ship?(ship)
    @board.has_value?(ship)
  end

  def format_pairs(coords)
    coords.split
  end

  def format_letters(coords)
    coords.chars
  end

  def vertical_coords?(formatted_coords)
    row_1 = formatted_coords[0]
    column_1 = formatted_coords[1]
    row_2 = formatted_coords[3]
    column_2 = formatted_coords[4]
    if column_1 == column_2
      true
    else
      false
    end
  end

  def horizontal_coords?(formatted_coords)
    row_1 = formatted_coords[0]
    column_1 = formatted_coords[1]
    row_2 = formatted_coords[3]
    column_2 = formatted_coords[4]
    if row_1 == row_2
      true
    else
      false
    end
  end

  def insert(ship, coords)
    formatted_coords = format_coords(coords)
    if valid_and_available_coords?(ship, formatted_coords)
      # insert plz
      # ship.place_on_board
    end
  end

  # def coords_exist?(formatted_coords)
  #   row_1 = formatted_coords[0]
  #   column_1 = formatted_coords[1]
  #   row_2 = formatted_coords[3]
  #   column_2 = formatted_coords[4]
  #   # checking if row exists
  #   if @board.has_key?(row_1) && @board.has_key?(row_2)
  #     true
  #   else
  #     false
  #     # abort("\nfuck off motherfuckers")
  #      # display error message from message class and exit, reprompt
  #   end
  #   # check if column exists for that row
  #   if @board[row_1].count >= (column_1.to_f - 1) &&
  #     @board[row_2].count >= (column_2.to_f - 1)
  #     true
  #   else
  #     false
  #     # abort("\nfuck off motherfuckers")
  #     # display error message from message class and exit, reprompt
  #   end
  # end

  def valid_and_available_coords?(ship, formatted_coords)
    # might break up into #valid_coords? && #available_coords?
    row_1 = formatted_coords[0]
    column_1 = formatted_coords[1]
    row_2 = formatted_coords[3]
    column_2 = formatted_coords[4]
    if ship_length_equals_coord_length(ship, formatted_coords) == false
      # display error message from message class, reprompt
    end
    if ship.size == 3
      spots_available?(row_1, column_1, row_2, column_2)
      middle_spot_available?(row_1, column_1, row_2, column_2)
      three_coordiates_adjacent?(row_1, column_1, row_2, column_2)
    else
      spots_available?(row_1, column_1, row_2, column_2)
      coordinates_adjacent?(row_1, column_1, row_2, column_2)      # ship size only 2
    end
  end

  def middle_spot_available?(row_1, column_1, row_2, column_2)

  end

  def three_coordiates_adjacent?(row_1, column_1, row_2, column_2)
    if column_1 == column_2 # vertical
      check_vertical_adjacent(row_1, row_2)
    elsif row_1 == row_2 # horizontal
      check_horizontal_adjacent(column_1, column_2)
    else
      # error message, exit, reprompt
    end
  end

  def check_vertical_adjacent(row_1, row_2)
    if row_2 > row_1
      if (row_1.codepoints.first + 1) == row_2.codepoints.first
        true
      else
        # error message, exit , reprompt
      end
    else
      if (row_2.codepoints.first + 1) == row_1.codepoints.first
        true
      else
        # error message, exit, reprompt
      end
    end
  end

  def check_horizontal_adjacent(column_1, column_2)
    if column_2 > column_1
      if (column_1 + 1) == column_2
        true
      else
        # error message, exit, reprompt
      end
    else
      if (column_2 + 1) == column_1
        true
      else
        # error message, exit, reprompt
      end
    end
  end

end
