require './lib/ledger.rb'
require './lib/ship.rb'
require './lib/player.rb'
require './lib/opponent.rb'
require './lib/messages.rb'
require './lib/firing_rules.rb'

class BattleShip
  include Messages
  include FiringRules
  attr_reader :opponent,
              :player
  def initialize
    @opponent = Opponent.new
    @player = Player.new
    puts Messages.begin_game
    puts Messages.beginning_prompt
    begin_game
  end

  def begin_game
    initial_input = gets.downcase.chomp
    if initial_input == 'p'
      puts Messages.setting
      opponent.place_ships_on_board
      player_ship_placement
    elsif initial_input == 'i'
      puts '===============' * 5
      puts Messages.instructions
      puts '===============' * 5
      puts Messages.beginning_prompt
      begin_game
    elsif initial_input == 'q'
      exit
    else
      puts '===============' * 5
      puts Messages.invalid_entry
      puts Messages.beginning_prompt
      begin_game
    end
  end

  def player_ship_placement
    if player.all_ships_sunk? == false && player.fleet[0].placed? == false
      puts Messages.finished_entering_ships
      puts player.ship_board.print_board
      coords = gets.upcase.chomp
      ship_1 = player.fleet[0]
      player.place_ship(ship_1, coords)
      player_ship_placement
    elsif player.all_ships_sunk? == false && player.fleet[0].placed? == true && player.fleet[1].placed? == false
      puts Messages.second_ship
      puts player.ship_board.print_board
      coords = gets.upcase.chomp
      ship_2 = player.fleet[1]
      player.place_ship(ship_2, coords)
      player_ship_placement
    else
      shot_sequence
    end
  end

  def shot_sequence
    if opponent.all_ships_sunk? == false && player.all_ships_sunk? == false
      opponent.fire(player.ship_board)
      # hit or miss message maybe in this method?
      coords = gets.upcase.chomp
      player.fire(opponent.ship_board, coords) #hot sure which class this goes in
      # hit or miss message
      # display shots fired board
      # player.shots_fired.print_board
      shot_sequence
    elsif opponent.all_ships_sunk?
      Messages.admits_victory
    elsif player.all_ships_sunk?
      Messages.admits_defeat
    else
      # message?
    end
  end
end

battleship = BattleShip.new
