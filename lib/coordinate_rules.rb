require './lib/ledger.rb'
require './lib/ship.rb'

module CoordinateRules

  @available_coords = ["A1", "A2", "A3", "A4",
                      "B1", "B2", "B3", "B4",
                      "C1", "C2", "C3", "C4",
                      "D1", "D2", "D3", "D4"]

  def self.coords_exist?(ledger, coords)
    coord_1, coord_2 = coords
    @available_coords.include?(coord_1)
    @available_coords.include?(coord_2)
  end

  def self.ship_length_equals_coord_length(ship, formatted_coords)
    coord_1, coord_2 = formatted_coords
    difference = @available_coords.index(coord_1) - @available_coords.index(coord_2)
    if ship.size == 2
      if difference.abs == 1 || difference.abs == 4
        true
      else
        false
      end
    else
      if difference.abs == 2 || difference.abs == 8
        true
      else
        false
      end
    end
  end

  def self.coords_empty?(ledger, coords)
    formatted_coords = ledger.format_letters(coords)
    row_1, column_1, space, row_2, column_2 = formatted_coords
    ledger.board[row_1][column_1.to_i] == 0 ? true : false
    ledger.board[row_2][column_2.to_i] == 0 ? true : false
  end

end
