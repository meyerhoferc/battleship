require_relative 'test_helper'
require './lib/messages.rb'

class MessagesTest < Minitest::Test
  include Messages

  def test_has_beginning_of_game_messages
    Messages.begin_game
  end

  def test_has_beginning_prompt_for_game
    Messages.beginning_prompt
  end
end
