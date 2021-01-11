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
      list << Tile.new(false, true)
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
        if (x + i) >= 0 && (y + j) >= 0 
          if (x + i) <= 8 && (y + j) <= 8
            neighbours << @board[x+i][y+j]
          end
        end
      end
    end
    
    neighbours.delete(@board[x][y])
    neighbours
  end

  

  def fringe_setter
    val = 0
    (0..8).each do |i|
      (0..8).each do |j|
        neighbour_finder([i,j]).each {|el| val += 1 if el.bombed == true}
        @board[i][j].neighbour_bomb_count(val)
        val = 0
      end
    end
  end 

  def flag_unflag_this(coord)
    x, y = coord
    @board[x][y].flag
  end

  def is_bomb?(coord)
    x,y = coord
    @board[x][y].bombed
  end

  def has_fringe?(coord)
    x,y = coord
    return true if @board[x][y].fringe > 0
  end 

  def is_revealed?(coord)
    x,y = coord
    return true if @board[x][y].revealed
    false
  end

  def find_coord(el)
    @board.each_with_index do |row, i|
      j = row.index(el)
      return i,j if j
    end
  end

  def reveal_board(coord)
    x,y = coord
    if has_fringe?(coord)
      @board[x][y].reveal
      return
    elsif @board[x][y].revealed
      return
    end
       
    @board[x][y].reveal
    neighbour_finder(coord).each {|el| reveal_board(find_coord(el))}
  end 

  def reveal_all_bombs
    @board.each do |row|
      row.each do |el|
        el.reveal if el.bombed
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

  def win
    @board.each do |row|
      return false if row.any?{|el| el.revealed == false && el.bombed == false}
    end
    return true
  end

end