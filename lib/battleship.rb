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
      puts player.shots_fired.print_board
      coords = gets.upcase.chomp
      ship_1 = player.fleet[0]
      player.place_ship(ship_1, coords)
      player_ship_placement
    elsif player.all_ships_sunk? == false && player.fleet[0].placed? == true && player.fleet[1].placed? == false
      puts Messages.second_ship
      puts player.shots_fired.print_board
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
      opponent_coords = opponent.fire
      if player.ship_board.contains_ship?(opponent_coords)
        puts Messages.computer_hit_ship
        ship = player.ship_board.find_and_hit_ship(opponent_coords)
        if ship.sunk?
          puts Messages.computer_sunk_ship
        end
      else
        puts Messages.computer_miss_ship
      end
      puts player.shots_fired.print_board
      puts Messages.prompt_for_coords
      player_coords = gets.upcase.chomp
      player.fire(opponent.ship_board, player_coords)
      if opponent.ship_board.contains_ship?(player_coords)
        player.shots_fired.mark_as_hit(player_coords)
        puts Messages.hit_ship
        ship = opponent.ship_board.find_and_hit_ship(player_coords)
        if ship.sunk?
          puts Messages.sunk_ship
        end
        puts player.shots_fired.print_board
      else
        player.shots_fired.mark_as_missed(player_coords)
        puts Messages.miss_ship
        puts player.shots_fired.print_board
      end
      shot_sequence
    elsif opponent.all_ships_sunk?
      puts Messages.admits_victory
      # end_game_sequence
    elsif player.all_ships_sunk?
      puts Messages.admits_defeat
      # end_game_sequence
    else
    end
  end
end

battleship = BattleShip.new
