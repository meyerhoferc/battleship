require './lib/ship.rb'

class Ledger
  attr_reader :difficulty,
              :board

  def initialize(difficulty = 1)
    @difficulty = difficulty
    @board = Hash.new
    @board['.'] = ['1', '2', '3', '4']
    @board['A'] = Array.new(3)
    @board['B'] = Array.new(3)
    @board['C'] = Array.new(3)
    @board['D'] = Array.new(3)
  end

  def has_ship?(ship)
    @board.has_value?(ship)
  end

  def insert(ship, coords)
    formatted_coords = format_coords(coords)
    if valid_and_available_coords?(ship, formatted_coords)
      #insert plz
      # ship.place_on_board
    end
  end

  def valid_and_available_coords?(ship, coords)
    # how will this work for 2 or 3?
    # if it takes ship, it should be able to determine length and proceed
    # have separate method for 3 length ship?
    # space exists in chars between beg & end coords
    row_1 = formatted_coords[0]
    column_1 = formatted_coords[1]
    row_2 = formatted_coords[3]
    column_2 = formatted_coords[4]
    # test ship length equals coord length
    # test both end spots available
    # test middle spot available
    # test adjacent
  end

  def format_coords(coords)
    coords.chars
  end

  def ship_length_equals_coord_length(ship, coords)

  end

  def spots_available(coords)
    # check for spots to be nil?
  end

end
