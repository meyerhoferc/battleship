module Messages
  def self.begin_game
    "\nWelcome to BATTLESHIP"
  end

  def self.beginning_prompt
    "\nWould you like to (p)lay, read the (i)nstructions, or (q)uit?"
  end

  def self.instructions
    """
    \nWhen prompted, select coords where you would like to place the ship.
    \nYou will enter the coordinates for the ships of your fleet, one with a length of two units and the other with a length of three units.
    \nI will tell you if your coordinates are valid. They must obey these rules:
    \n\t1. Ships cannot overlap each other.
    \n\t2. Ships cannot wrap around the edges of the board, as they are not bendy.
    \n\t3. Ship orientation must be horizontal or vertical, never diagonal.
    \n\t4. Ship coordinates must match the size of the ship.
    \n\t5. Ship coordinates must coorespond to existing rows and columns in the board."""
  end

  def self.setting
    """
    \nIn the usually tranquil zone of Undercity, you are Anklesmiter, a goblin shadowpriest being challenged to a Battleship duel from a lowly human paladin.
    \nYou must defend the honor of the Horde. Dark Lady watch over you, Anklesmiter.
    """
  end

  def self.threaten
    "[Gretchen]: I WILL CRUSH YOU....with my ships."
  end

  def self.admits_defeat
    "[Gretchen]: Well played, Anklesmiter. You have bested me."
  end

  def self.admits_victory
    "[Gretchen]: Well played, Anklesmiter. You cannot defeat the Light."
  end
end
