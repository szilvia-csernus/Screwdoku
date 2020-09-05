require_relative "board"
require 'colorize'


class SudokuGame
  def self.from_file(filename)
    board = Board.from_file(filename)
    self.new(board)
  end

  def initialize(board)
    @board = board
  end

  def get_pos
    pos = nil
    until pos && valid_pos?(pos)
      puts "Please enter a position on the board (e.g., '3,4')"
      print "> "

      begin
        pos = gets.chomp.split(",").map { |char| Integer(char)}
      rescue 
        puts  "#{$!}"
        # TODO: Google how to print the error that happened inside of a rescue statement.
        puts "Invalid position entered (did you use a comma?)"
        puts ""

        pos = nil
      end
    end
    pos
  end

  def get_val
    val = nil
    until val && valid_val?(val)
      puts "Please enter a value between 1 and 9 (0 to clear the tile)"
      print "> "
      val = gets.chomp.to_i
    end
    val
  end

  def play_turn
    board.render
    pos = get_pos
    val = get_val
    board[pos] = val
  end

  def run
    play_turn until board.solved?
    board.render
    puts "Congratulations, you win!"
  end

  def valid_pos?(pos)
    if pos.is_a?(Array) &&
      pos.length == 2 &&
      pos.all? { |x| (0..board.size - 1).include?(x) }
      return true
    else
      false
    end
  end

  def valid_val?(val)
    val.is_a?(Integer) ||
      val.between?(0, 9)
  end

  private
  attr_reader :board
end


game = SudokuGame.from_file("puzzles/sudoku1-almost.txt")
game.run
