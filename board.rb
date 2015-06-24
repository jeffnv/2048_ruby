re 'byebug'
class Board
  DIRECTIONS = [:left, :right, :up, :down]
  BOARD_SIZE = 4
  attr_reader :grid

  def initialize(grid = nil)
    if grid
      @grid = grid
    else
      @grid = Array.new(BOARD_SIZE) { Array.new(BOARD_SIZE) } 
      2.times { add_random_two }
    end
  end

  def add_random_two
    col = rand(BOARD_SIZE)
    row = rand(BOARD_SIZE)
    if @grid[row][col].nil?
      puts "added a two"
      @grid[row][col] = 2 
    else
      add_random_two
    end
  end

  def over?
    @grid.all? { |row| row.all? { |tile| !tile.nil? } }
  end

  def dup
    Board.new(@grid.map { |row| row.dup })
  end

  def ==(other)
    other.grid.each_with_index do |row, row_index|
      return false if row != self.grid[row_index]
    end
    true
  end

  def move(dir)
    return unless DIRECTIONS.include?(dir)
    before_move = self.dup
    case dir
    when :left
      @grid.map! { |row| slide_row(row) }
    when :right
      @grid.map! { |row| slide_row(row.reverse).reverse }
    when :up
      transposed = @grid.transpose
      @grid = @grid.transpose.map { |row| slide_row(row) }.transpose
    when :down
      @grid = @grid.transpose.map { |row| slide_row(row.reverse).reverse }.transpose
    end
    add_random_two if before_move != self
  end

  def slide_row(row)
    slid_array = row.compact
    # get rid of all the nils
    i = 0
    while i < (slid_array.length - 1)
      if slid_array[i] == slid_array[i + 1]
        slid_array[i] = slid_array[i] * 2
        slid_array.delete_at(i + 1)
      end
      i += 1
    end
    #pad with nils so it is same length
    slid_array + Array.new(row.length - slid_array.length)
  end

  def inspect
    to_s
  end

  def to_s
    content = ""
    @grid.each do |row|
      row.each do |num| 
        content << (num || "*").to_s
      end
      content << "\n"
    end
    content
  end

  def render
    puts self
  end
end

