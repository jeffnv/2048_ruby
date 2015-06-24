require_relative "board"

class Twenty48
  DIR_MAP = {'j' => :down, 'h' => :left, 'k' => :up, 'l' => :right}
  def initialize
    @board = Board.new
  end

  def play
    until @board.over?
      system("clear")
      @board.display
      @board.move(get_dir)
    end
    @board.display
    result = @board.won? ? "YOU WON! :)" : "YOU DIDN'T WIN :/"
    puts result
  end

  private

  def get_dir
    puts "enter direction using vi keys (h, j, k, l)"
    dir = get_char
    if DIR_MAP.keys.include?(dir)
      DIR_MAP[dir]
    else
      get_dir
    end
  end

  def get_char
    state = `stty -g`
    `stty raw -echo -icanon isig`

    STDIN.getc.chr
  ensure
    `stty #{state}`
  end

end

Twenty48.new.play
