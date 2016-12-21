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
    \nIn the usually tranquil zone of Undercity, you are Anklesmiter, a goblin shadowpriest being challenged to a Battleship duel from a lowly human paladin.
    \nYou must defend the honor of the Horde. Dark Lady watch over you, Anklesmiter.
    """
    assert_equal message, Messages.setting
  end

  def test_opponent_threatens
    message = "[Gretchen]: I WILL CRUSH YOU....with my ships."
    assert_equal message, Messages.threaten
  end

  def test_admits_defeat
    message = "[Gretchen]: Well played, Anklesmiter. You have bested me."
    assert_equal message, Messages.admits_defeat
  end

  def test_admits_victory
    message = "[Gretchen]: Well played, Anklesmiter. You cannot defeat the Light."
    assert_equal message, Messages.admits_victory
  end
end
