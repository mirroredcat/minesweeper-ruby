require_relative "tile"

class Board

  def self.empty_grid
    Array.new(9){Array.new(9)}
  end

  def self.populate
    list = []
    10.times do
      list << Tile.new(false, true, false)
    end
    (9*9 - 10).times do 
      list << Tile.new
    end
    list.shuffle!
    list.each_slice(9){|sl| tiles << sl}
    self.new(tiles)
  end 


  def initialize(grid = self.empty_grid)
    @board = grid
  end

  def [](pos)
    x, y = pos
    board[x][y]
  end

  def []=(pos,val)
    x, y = pos
    tile = board[x][y]
    tile.fringe = val
  end

end