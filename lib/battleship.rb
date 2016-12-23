require './lib/ledger.rb'
require './lib/ship.rb'
require './lib/player.rb'
require './lib/opponent.rb'
require './lib/messages.rb'
require './lib/firing_rules.rb'
require 'pry'

class BattleShip
  include Messages
  include FiringRules
  attr_reader :opponent,
              :player
  def initialize
    @opponent = Opponent.new
    @player = Player.new
    puts Messages.begin_game
    puts Messages.setting
    puts Messages.beginning_prompt
    begin_game
  end

  def begin_game
    initial_input = gets.downcase.chomp
    if initial_input == 'p'
      @initial_time = Time.now
      opponent.place_ships_on_board
      player_ship_placement
    elsif initial_input == 'i'
      instructions
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

  def instructions
    puts '===============' * 5
    puts Messages.instructions
    puts '===============' * 5
    puts Messages.beginning_prompt
  end

  def player_ship_placement
    if player.all_ships_sunk? == false && player.fleet[0].placed? == false
      puts '===============' * 5
      puts Messages.finished_entering_ships
      place_first_ship
    elsif player.all_ships_sunk? == false && player.fleet[0].placed? == true && player.fleet[1].placed? == false
      puts '===============' * 5
      puts Messages.second_ship
      place_second_ship
    else
      shot_sequence
    end
  end

  def ship_coords_all_valid?(ship, coords)
    if player.ship_board.valid_and_available_coords?(ship, coords)
      true
    else
      false
    end
  end

  def place_first_ship
    puts player.shots_fired.print_board
    coords = gets.upcase.chomp
    ship_1 = player.fleet[0]
    if ship_coords_all_valid?(ship_1, coords)
      player.place_ship(ship_1, coords)
      player_ship_placement
    else
      puts Messages.invalid_entry
      place_first_ship
    end
  end

  def place_second_ship
    puts player.shots_fired.print_board
    coords = gets.upcase.chomp
    ship_2 = player.fleet[1]
    if ship_coords_all_valid?(ship_2, coords)
      player.place_ship(ship_2, coords)
      player_ship_placement
    else
      puts Messages.invalid_entry
      place_second_ship
    end
  end

  def shot_sequence
    if opponent.all_ships_sunk? == false && player.all_ships_sunk? == false
      opponent_coords = opponent.fire
      if player.ship_board.contains_ship?(opponent_coords)
        computer_hits_ship(opponent_coords)
      else
        puts '===============' * 5
        puts Messages.computer_miss_ship
      end
      player_shot_sequence
      shot_sequence
    else
      declare_winner
    end
  end

  def declare_winner
    if opponent.all_ships_sunk?
      puts '===============' * 5
      puts Messages.admits_defeat
      end_game_sequence("player", player)
    elsif player.all_ships_sunk?
      puts '===============' * 5
      puts Messages.admits_victory
      end_game_sequence("opponent", opponent)
    else
      puts "\nIt was a tie!"
      end_game_sequence(tie)
    end
  end

  def computer_hits_ship(opponent_coords)
    puts '===============' * 5
    puts Messages.computer_hit_ship
    ship = player.ship_board.find_and_hit_ship(opponent_coords)
    if ship.sunk?
      puts Messages.computer_sunk_ship
    end
  end

  def player_shot_sequence
    puts player.shots_fired.print_board
    puts Messages.prompt_for_coords
    player_coords = gets.upcase.chomp
    if player.valid_firing_coords?(player_coords)
      player.fire(opponent.ship_board, player_coords)
      check_if_player_hit_or_miss(player_coords)
    else
      puts Messages.invalid_entry
      player_shot_sequence
    end
  end

  def check_if_player_hit_or_miss(player_coords)
    if opponent.ship_board.contains_ship?(player_coords)
      player.shots_fired.mark_as_hit(player_coords)
      puts '===============' * 5
      puts Messages.hit_ship
      ship = opponent.ship_board.find_and_hit_ship(player_coords)
      if ship.sunk?
        puts Messages.sunk_ship
      end
      puts player.shots_fired.print_board
    else
      player.shots_fired.mark_as_missed(player_coords)
      puts '===============' * 5
      puts Messages.miss_ship
      puts player.shots_fired.print_board
    end
  end

  def end_game_sequence(winner_name, winner)
    @final_time = Time.now
    time_elapsed = (@final_time - @initial_time).round
    puts Messages.total_time(time_elapsed)
    puts Messages.winner_shots(winner_name, winner.shots)
  end
end

battleship = BattleShip.new
