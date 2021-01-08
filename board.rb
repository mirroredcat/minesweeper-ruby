require_relative "tile"

class Board

  attr_reader :board

  def initialize
    @board = Array.new(9){Array.new(9)}
  end

  def populate
    list = []
    10.times do
      list << Tile.new(false, true, false)
    end
    (9*9 - 10).times do 
      list << Tile.new
    end
    list.shuffle!
    (0..8).each do |x|
      (0..8).each do |y|
        @board[x][y] = list.shift
      end
    end
  end 


  

  def [](pos)
    x, y = pos
    board[x][y]
  end

  def []=(pos,val)
    x, y = pos
    board[x][y] = val   
  end

  def neighbour_finder(arr)
    x, y = arr
    min = 0
    max = 9
    neighbours = []
    # corners
    # if x == min
    #   if y == max || y == min
    #     neighbours = 

    #edges

    #regular
    # x-1, x, x +1
    # y-1, y, y+1
    (-1..1).each do |i|
      (-1..1).each do |j|
        neighbours << @board[x+i][y+j] if (x + i) != x && (y + j) != y
      end
    end
        


    neighbours
  end

end