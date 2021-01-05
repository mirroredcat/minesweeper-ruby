class Tile

  attr_accessor :revealed, :bombed, :flagged

  def initialize(revealed = false, bombed = false, flagged = false)
    @revealed = revealed
    @bombed = bombed
    @flagged = flagged
    @fringe = nil
  end

  def reveal
    @revealed = true
  end

  def flag
    if flagged
      flagged = false
    else
      flagged = true
    end
  end

  def neighbour_bomb_count(val)
    @fringe = val
  end

end