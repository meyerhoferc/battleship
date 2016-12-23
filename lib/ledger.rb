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

  def print_board
    keys = @board.keys
    columns = @board[keys[0]]
    row_1 = @board[keys[1]]
    row_2 = @board[keys[2]]
    row_3 = @board[keys[3]]
    row_4 = @board[keys[4]]
    row_1_new = []
    row_2_new = []
    row_3_new = []
    row_4_new = []
    make_row_printable(row_1, row_1_new)
    make_row_printable(row_2, row_2_new)
    make_row_printable(row_3, row_3_new)
    make_row_printable(row_4, row_4_new)
    border = '============'
    printed_board = """
    #{border}
    #{keys[0]} #{columns[0]} #{columns[1]} #{columns[2]} #{columns[3]}
    #{keys[1]} #{row_1_new[0]} #{row_1_new[1]} #{row_1_new[2]} #{row_1_new[3]} #{row_1_new[4]}
    #{keys[2]} #{row_2_new[0]} #{row_2_new[1]} #{row_2_new[2]} #{row_2_new[3]} #{row_2_new[4]}
    #{keys[3]} #{row_3_new[0]} #{row_3_new[1]} #{row_3_new[2]} #{row_3_new[3]} #{row_3_new[4]}
    #{keys[4]} #{row_4_new[0]} #{row_4_new[1]} #{row_4_new[2]} #{row_4_new[3]} #{row_4_new[4]}
    #{border}
    """
  end

  def make_row_printable(row, new_row)
    row.each do |i|
      if i == 0
        i = " "
      end
      new_row << i
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
    if valid_and_available_coords?(ship, coords)
      row_1, column_1, space, row_2, column_2 = format_letters(coords)
      @board[row_1][column_1.to_i - 1] = ship
      @board[row_2][column_2.to_i - 1] = ship
      if ship.size == 3
        mark_middle_spot(ship, coords)
      end
      ship.place_on_board
    else
      false
    end
  end

  def coords_nil?(coords)
    CoordinateRules.coords_nil?(self, coords)
  end

  def all_rules_pass?(ship, coords)
    exist = CoordinateRules.coords_exist?(self, coords) ? true : false
    empty = CoordinateRules.coords_empty?(self, coords) ? true : false
    size = CoordinateRules.ship_length_equals_coord_length(self, ship, coords) ? true : false
    adjacent = CoordinateRules.coordinates_adjacent?(self, coords) ? true : false
    exist && size && empty && adjacent
  end

  def valid_and_available_coords?(ship, coords)
    unless coords_nil?(coords)
      all_rules_pass?(ship, coords)
      if ship.size == 3
        empty = CoordinateRules.all_three_empty?(self, coords) ? true : false
        adjacent = CoordinateRules.all_three_adjacent?(self, coords) ? true : false
        empty && adjacent
      end
      true
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
    end
    @board[middle_row][middle_column] = ship
  end

  def contains_ship?(coord)
    formatted_coord = format_letters(coord)
    row, column = formatted_coord
    @board[row][column.to_i - 1] == 0 ? false : true
  end

  def coordinate_struck?(coord)
    formatted_coord = format_letters(coord)
    row, column = formatted_coord
    @board[row][column.to_i - 1] == 0 ? false : true
  end

  def mark_as_missed(coord)
    formatted_coord = format_letters(coord)
    row, column = formatted_coord
    @board[row][column.to_i - 1] = "M"
  end

  def mark_as_hit(coord)
    formatted_coord = format_letters(coord)
    row, column = formatted_coord
    @board[row][column.to_i - 1] = "H"
  end

  def find_and_hit_ship(coord)
    formatted_coord = format_letters(coord)
    row, column = formatted_coord
    ship = @board[row][column.to_i - 1]
    ship.hit
    ship
  end
end
