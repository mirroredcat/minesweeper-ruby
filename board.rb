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
    @board[pos]
  end

  def []=(pos,val)
    @board[pos] = val   
  end

  def neighbour_finder(arr)
    x, y = arr
    neighbours = []
    (-1..1).each do |i|
      (-1..1).each do |j|
        neighbours << @board[x+i][y+j] if (x + i) >= 0 && (y + j) >= 0
      end
    end
    
    neighbours.delete(@board[x][y])
    neighbours
  end

  

  def render
    by_row = []
    puts "  #{(0..8).to_a.join(" ")}"
    board.each_with_index do |row, i|
      board.each_with_index do |el, j|
        by_row << board[i][j].value
      end
      puts "#{i} #{by_row.join(" ")}"
      by_row = []
    end
  end

end