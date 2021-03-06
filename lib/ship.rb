class Ship
  attr_reader :size
  def initialize(size)
    @size = size
    @placed = false
    @hit_counter = 0
    @sunk = false
  end

  def placed?
    @placed
  end

  def place_on_board
    @placed = true
  end

  def times_hit
    @hit_counter
  end

  def hit
    @hit_counter += 1
    if @hit_counter == @size
      @sunk = true
    end
  end

  def sunk?
    @sunk
  end
end
