require_relative "tile"
require "byebug"

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
        # debugger
        if (x + i) >= 0 && (y + j) >= 0 
          if (x + i) <= 8 && (y + j) <= 8
            neighbours << @board[x+i][y+j].bombed 
          end
        end
      end
    end
    
    neighbours.delete(@board[x][y])
    neighbours
  end

  def fringe_setter
    (0..8).each do |i|
      (0..8).each do |j|
        val = neighbour_finder([i,j]).count(true)
        @board[i][j].neighbour_bomb_count(val)
      end
    end
        
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