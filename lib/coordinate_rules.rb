require './lib/ledger.rb'
require './lib/ship.rb'
require 'pry'

module CoordinateRules

  @available_coords = ["A1", "A2", "A3", "A4",
                      "B1", "B2", "B3", "B4",
                      "C1", "C2", "C3", "C4",
                      "D1", "D2", "D3", "D4"]

  def self.coords_exist?(ledger, coords)
    formatted_coords = ledger.format_pairs(coords)
    coord_1, coord_2 = formatted_coords
    @available_coords.include?(coord_1)
    @available_coords.include?(coord_2)
  end

  def self.ship_length_equals_coord_length(ledger, ship, coords)
    formatted_coords = ledger.format_pairs(coords)
    coord_1, coord_2 = formatted_coords
    difference = @available_coords.index(coord_1) - @available_coords.index(coord_2)
    if ship.size == 2
      difference.abs == 1 || difference.abs == 4 ? true : false
    elsif ship.size == 3
      difference.abs == 2 || difference.abs == 8 ? true : false
    else
    end
  end

  def self.coords_empty?(ledger, coords)
    formatted_coords = ledger.format_letters(coords)
    row_1, column_1, space, row_2, column_2 = formatted_coords
    ledger.board[row_1][column_1.to_i - 1] == 0 ? true : false
    ledger.board[row_2][column_2.to_i - 1] == 0 ? true : false
  end

  def self.coordinates_adjacent?(ledger, coords)
    coord_1, coord_2 = ledger.format_pairs(coords)
    formatted_coords = ledger.format_letters(coords)
    row_1, column_1, space, row_2, column_2 = formatted_coords
    row_1 == row_2 || column_1 == column_2 ? true : false

    coord_1_index = @available_coords.index(coord_1)
    coord_2_index = @available_coords.index(coord_2)
    difference = coord_1_index - coord_2_index
    difference.abs == 1 || difference.abs == 4 ? true : false
  end

  def self.all_three_empty?(ledger, coords)
    formatted_coords = ledger.format_letters(coords)
    row_1, column_1, space, row_2, column_2 = formatted_coords
    if row_1 == row_2
      middle_row = row_1
      column_1.to_i > column_2.to_i ? middle_column = (column_2.to_i) : middle_column = (column_1.to_i)
    elsif column_1 == column_2
      middle_column = column_1.to_i - 1
      row_1_c = row_1.codepoints.first
      row_2_c = row_2.codepoints.first
      row_1_c > row_2_c ? middle_row = [row_2_c + 1].pack("U*") : middle_row = [row_1_c + 1].pack("U*")
    else
    end
    ledger.board[row_1][column_1.to_i - 1] == 0 ? true : false
    ledger.board[row_2][column_2.to_i - 1] == 0 ? true : false
    ledger.board[middle_row][middle_column] == 0 ? true : false
  end

  def self.all_three_adjacent(ledger, coords)
    coord_1, coord_2 = ledger.format_pairs(coords)
    # check horizontal ? 2 indices, no wraps
    # check vertical ? 8 indices, no wraps
  end

  def self.coords_nil?(ledger, coords)
    formatted_coords = ledger.format_pairs(coords)
    coord_1, coord_2 = formatted_coords
    @available_coords.index(coord_1).nil? ? true : false
    @available_coords.index(coord_2).nil? ? true : false
  end

end
