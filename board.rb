require_relative "tile"

class Board
  attr_reader :grid

  def self.empty_grid
    empty_grid = Array.new(9) do
      Array.new(9) { Tile.new(0) }
    end
    empty_grid
  end

  def self.from_file(filename)
    rows = File.readlines(filename).map(&:chomp)
    tiles = rows.map do |row|
      nums = row.split("").map { |char| Integer(char) }
      nums.map { |num| Tile.new(num) }
    end

    self.new(tiles)
  end

  def initialize(grid = self.empty_grid)
    @grid = grid
  end

  def [](pos)
    pos = x,y
    @grid[x][y]
  end

  def []=(pos, val)
    x, y = pos
    tile = grid[x][y]
    tile.value = val
  end

  def columns
    @grid.transpose
  end

  def render
    puts "  #{(0..8).to_a.join(" ")}"
    grid.each_with_index do |row, i|
      puts "#{i} #{row.join(" ")}"
    end
  end


  def size
    @grid.size
  end

  def solved?
    @grid.all? { |row| solved_set?(row) } &&

      columns.all? { |col| solved_set?(col) } &&
      squares.all? { |square| solved_set?(square) }
      
  end

  def solved_set?(tiles)
    nums = tiles.map(&:value)
    nums.sort == (1..9).to_a
  end

  def squares
    sq_tiles = Array.new(9) {[]}
    
    (0..8).to_a.each do |x| 
        (0..8).to_a.each do |y| 
            square_x = (x / 3) * 3
            square_y = (y / 3) * 3
            square_num = square_x + square_y / 3
            sq_tiles[square_num] << @grid[x][y]
        end
    end
    sq_tiles
  end


end

