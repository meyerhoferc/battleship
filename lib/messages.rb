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
    "\n[Gretchen]: I WILL CRUSH YOU....with my ships."
  end

  def self.admits_defeat
    "\n[Gretchen]: Well played, Anklesmiter. You have bested me."
  end

  def self.admits_victory
    "\n[Gretchen]: Well played, Anklesmiter. You cannot defeat the Light."
  end

  def self.finished_entering_ships
    "\n[Gretchen]: I have laid out my ships on the grid.
    \nYou now need to layout your two ships.
    \nThe first is two units long and the second is three units long.
    \nThe grid has A1 at the top left and D4 at the bottom right.
    \nEnter the squares for the two-unit ship:\n"
  end

  def self.computer_hit_ship
    "\nI hit your ship! I will eventually sink all your ships!"
  end

  def self.computer_miss_ship
    "\nI missed the ship!"
  end

  def self.hit_ship
    "\nYou hit the ship!\nHere's a updated view:\n"
  end

  def self.miss_ship
    "\nYou missed the ship!\nHere's a updated view:\n"
  end

  def self.invalid_entry
    "\nUnfortunately, that input was invalid. Please try again:\n"
  end

  def self.second_ship
    "\nEnter coordinates for your second ship. Make sure these are for a ship of 3 units in length."
  end

  def self.computer_sunk_ship
    "\nI have sunk your ship! The Light shall prevail!"
  end

  def self.sunk_ship
    "\nYou sank my ship, but it's not a big deal. The Light shall burn you!"
  end

  def self.prompt_for_coords
    "\nEnter the coordinates you would like to fire at."
  end
end
