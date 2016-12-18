class Ship
  attr_reader :size
  def initialize(size)
    @size = size
    @placed = false
  end

  def placed?
    @placed
  end

  def place_on_board
    @placed = true 
  end

end
