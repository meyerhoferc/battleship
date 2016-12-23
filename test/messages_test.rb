require_relative 'test_helper'
require './lib/messages.rb'

class MessagesTest < Minitest::Test
  include Messages

  def test_has_beginning_of_game_messages
    message = "\nWelcome to BATTLESHIP"
    assert_equal message, Messages.begin_game
  end

  def test_has_beginning_prompt_for_game
    message = "\nWould you like to (p)lay, read the (i)nstructions, or (q)uit?"
    assert_equal message, Messages.beginning_prompt
  end

  def test_has_instructions_for_game
    message = """
    \nWhen prompted, select coords where you would like to place the ship.
    \nYou will enter the coordinates for the ships of your fleet, one with a length of two units and the other with a length of three units.
    \nI will tell you if your coordinates are valid. They must obey these rules:
    \n\t1. Ships cannot overlap each other.
    \n\t2. Ships cannot wrap around the edges of the board, as they are not bendy.
    \n\t3. Ship orientation must be horizontal or vertical, never diagonal.
    \n\t4. Ship coordinates must match the size of the ship.
    \n\t5. Ship coordinates must coorespond to existing rows and columns in the board."""
    assert_equal message, Messages.instructions
  end

  def test_battleship_has_a_setting
    message = """
    \nIn the usually tranquil zone of Undercity, you are Anklesmiter, a goblin shadowpriest being challenged to a Battleship duel from Gretchen, a lowly human paladin.
    \nYou must defend the honor of the Horde. Dark Lady watch over you, Anklesmiter.
    """
    assert_equal message, Messages.setting
  end

  def test_opponent_threatens
    message = "\n[Gretchen]: I WILL CRUSH YOU....with my ships."
    assert_equal message, Messages.threaten
  end

  def test_admits_defeat
    message = "\n[Gretchen]: Well played, Anklesmiter. You have bested me."
    assert_equal message, Messages.admits_defeat
  end

  def test_admits_victory
    message = "\n[Gretchen]: Well played, Anklesmiter. You cannot defeat the Light."
    assert_equal message, Messages.admits_victory
  end

  def test_says_when_finished_enterting_ships_onto_board
    message = "\n[Gretchen]: I have laid out my ships on the grid.
    \nYou now need to layout your two ships.
    \nThe first is two units long and the second is three units long.
    \nThe grid has A1 at the top left and D4 at the bottom right.
    \nEnter the squares for the two-unit ship:\n"

    assert_equal message, Messages.finished_entering_ships
  end

  def test_gives_message_when_hit_ship
    message = "\n[Gretchen]: You hit my ship!\nHere's a updated view:\n"
    assert_equal message, Messages.hit_ship
  end

  def test_gives_message_when_you_miss_ship
    message = "\n[Gretchen]: You missed my ship!\nHere's a updated view:\n"
    assert_equal message, Messages.miss_ship
  end

  def test_has_invalid_entry_message
    message = "\nUnfortunately, that input was invalid. Please try again:\n"
    assert_equal message, Messages.invalid_entry
  end

  def test_enter_second_ship_messages
    message = "\nEnter coordinates for your second ship. Make sure these are for a ship of 3 units in length."
    assert_equal message, Messages.second_ship
  end

  def test_gives_message_when_computer_sinks_ship
    message = "\n[Gretchen]: I have sunk your ship! The Light shall prevail!"
    assert_equal message, Messages.computer_sunk_ship
  end

  def test_gives_message_when_player_sinks_ship
    message = "\n[Gretchen]: You sank my ship, but it's not a big deal. The Light shall burn you!"
    assert_equal message, Messages.sunk_ship
  end

  def test_gives_message_for_prompting_coordinates_from_player
    message =  "\nEnter the coordinates you would like to fire at."
    assert_equal message, Messages.prompt_for_coords
  end

  def test_gives_message_when_computer_misses_ship
    message = "\n[Gretchen]: I missed your ship!"
    assert_equal message, Messages.computer_miss_ship
  end

  def test_gives_message_when_computer_hit_ship
    message = "\n[Gretchen]: I hit your ship! I will eventually sink all your ships!"
    assert_equal message, Messages.computer_hit_ship
  end

  def test_reports_on_duration_of_game
    message = "\nThe total time of the game was 5 seconds long."
    assert_equal message, Messages.total_time(5)
  end

  def test_reports_how_many_shots_winner_took
    message = "\nYou took 10 shots in order to win."
    assert_equal message, Messages.winner_shots("player", 10)
  end
end
