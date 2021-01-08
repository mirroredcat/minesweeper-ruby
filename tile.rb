class Tile

  

  def initialize(revealed = false, bombed = false, flagged = false, value = "*")
    @revealed = revealed
    @bombed = bombed
    @flagged = flagged
    @fringe = 0
    @value = value

  end

  def value
    if @revealed == true
      if @bombed == true
        @value = "B"
      elsif @fringe != 0
        @value = @fringe.to_s
      else
        @value = " "
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
    else
      flagged = true
    end
  end

  def neighbour_bomb_count(val)
    @fringe = val
  end

end