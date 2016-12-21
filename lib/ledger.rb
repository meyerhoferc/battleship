require './lib/ship.rb'
require './lib/messages.rb'
require './lib/coordinate_rules.rb'
require 'pry'

class Ledger
  include CoordinateRules
  attr_reader :difficulty,
              :board

  def initialize(difficulty = 1)
    @difficulty = difficulty
    @board = Hash.new
    @board['.'] = ['1', '2', '3', '4']
    letters = ['A', 'B', 'C', 'D']
    letters.each do |letter|
      @board[letter] = Array.new(4, 0)
    end
  end

  def has_ship?(ship)
    @board.values.any? { |value| value.include?(ship) }
  end

  def format_pairs(coords)
    coords.split
  end

  def format_letters(coords)
    coords.chars
  end

  def insert(ship, coords)
    valid_and_available_coords?(ship, coords)
    row_1, column_1, space, row_2, column_2 = format_letters(coords)
    @board[row_1][column_1.to_i - 1] = ship
    @board[row_2][column_2.to_i - 1] = ship
    if ship.size == 3
      mark_middle_spot(ship, coords)
    end
    ship.place_on_board
  end

  def valid_and_available_coords?(ship, coords)
    CoordinateRules.coords_exist?(self, coords)
    CoordinateRules.ship_length_equals_coord_length(self, ship, coords)
    CoordinateRules.coords_empty?(self, coords)
    CoordinateRules.coordinates_adjacent?(self, coords)
    if ship.size == 3
      CoordinateRules.all_three_empty?(self, coords)
    end
  end

  def mark_middle_spot(ship, coords)
    row_1, column_1, space, row_2, column_2 = format_letters(coords)
    if row_1 == row_2 # horizontal
      middle_row = row_1
      column_1.to_i > column_2.to_i ? middle_column = (column_2.to_i) : middle_column = (column_1.to_i)
    elsif column_1 == column_2 # vertical
      middle_column = column_1.to_i - 1
      row_1_c = row_1.codepoints.first
      row_2_c = row_2.codepoints.first
      row_1_c > row_2_c ? middle_row = [row_2_c + 1].pack("U*") : middle_row = [row_1_c + 1].pack("U*")
    else
      # wtf do i do now
    end
    @board[middle_row][middle_column] = ship
  end
end
