require "colorize"

puts "MUAHAHA.  The dastardly unexpected end statement.\n".red
puts "Do NOT try to solve this error by going one method at a time and looking for an 'end'.\n".red
puts "Instead, comment out half of the bad file at a time until the error changes.  Keep narrowing down from there.".red
puts ""
puts "Does this approach feel familiar?  The approach is a version of binary search.\n\n".red

require_relative "board"
require 'colorize'


# People write terrible method names in real life.
# On the job, it is your job to figure out how the methods work and then name them better.
# Do this now.

class SudokuGame
  def self.from_file(filename)
    board = Board.from_file(filename)
    self.new(board)
  end

  def initialize(board)
    @board = board
  end


  def retrieve_pos_from_ui
    p = nil
    until p && valid_pos?(p)

      puts "Please enter a position on the board (e.g., '3,4')"
      print "> "

      begin

        pos = gets.chomp.split(",").map { |char| Integer(char)}
      rescue 
        puts  "#{$!}"
        # TODO: Google how to print the error that happened inside of a rescue statement.

        puts "Invalid position entered (did you use a comma?)"
        puts ""

        p = nil
      end
    end
    p
  end


  def retrieve_value_from_ui
    v = nil
    until v && valid_val?(v)
      puts "Please enter a value between 1 and 9 (0 to clear the tile)"
      print "> "

      val = gets.chomp.to_i

    end
    v
  end


  def play_turn

    board.render

    pos_to_val(retrieve_pos_from_ui, retrieve_value_from_ui)
  end

  def pos_to_val(p, v)
    board[p] = v
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
