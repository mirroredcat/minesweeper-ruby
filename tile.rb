class Tile

  attr_reader :bombed, :fringe, :flagged, :revealed

  def initialize(revealed = false, bombed = false, flagged = false, value = "*")
    @revealed = revealed
    @bombed = bombed
    @flagged = flagged
    @fringe = 0
    @value = value
  end

  def value
    if @revealed 
      if @bombed 
        @value = "B"
      elsif @fringe != 0
        @value = @fringe.to_s
      else
        @value = "_"
      end
    else
      @value
    end
  end

  def reveal
    @revealed = true
  end

  def flag
    if flagged
      flagged = false
      @value = "*"
    else
      flagged = true
      @value = "F"
    end
  end

  def neighbour_bomb_count(val)
    @fringe = val
  end

end