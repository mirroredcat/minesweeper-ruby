require_relative "board"
require "byebug"

class Minesweeper
  

  def initialize
    board = Board.new
    board.populate
    board.fringe_setter
    @board = board
    @game_over = false
  end

  def parse_pos(str)
    str.split(",").map {|char| Integer(char)}
  end

  def valid_pos(pos)
    pos.is_a?(Array) &&
      pos.length == 2 &&
      pos.all? { |x| x.between?(0, 8)} &&
      @board.is_revealed?(pos) == false
  end

  def get_pos
    pos = nil
    until pos && valid_pos(pos)
      puts "Choose a position to reveal or flag (format 3,4)"
      begin
        pos = parse_pos(gets.chomp)
      rescue
        puts "Invalid position (did you forget the ,) or already revealed"
        puts
        pos = nil
      end
    end
    pos
  end

  def game_over?(pos)
    if @board.is_bomb?(pos)
      puts "Game over"
      @board.reveal_all_bombs
      @game_over = true
      return true
    end
    return false
  end


  def flag_or_reveal?
    answ = ""
    until answ == "r" || answ == "f"
      puts "Would you like to reveal or flag?(r/f)"
      answ = gets.chomp.downcase
    end
    answ
  end



  def play_round
    @board.render
    # debugger
    answ = flag_or_reveal?
    if answ == "r"
      pos = get_pos
      @board.reveal_board(pos)
      game_over?(pos)
    else
      pos = get_pos
      @board.flag_unflag_this(pos)
    end
  end

  def won
    if @board.win
      puts "Hooray! You won!"
      return true
    else
      return false
    end
  end


  def run
    play_round until won || @game_over
    @board.render
  end

end

game = Minesweeper.new
game.run