# Represents a single tile on the 3x3 tic tac toe board
class Tile
  EMPTY = :EMPTY
  X_SYMBOL = :X_SYMBOL
  O_SYMBOL = :O_SYMBOL

  attr_reader :value

  def initialize(main_win, x_offset, y_offset, side_size)
    @width = side_size - 2
    @height = side_size - 2
    @win = main_win.subwin(@width, @height, x_offset + 2, y_offset + 2)
    @value = EMPTY
  end

  def value=(val)
    @value = val
    draw
  end

  def select
    @win.color_set(Screen::HIGHLIGHT_COLOR)
  end

  def deselect
    @win.color_set(Screen::NORMAL_COLOR)
  end

  private

  def draw
    case @value
    when EMPTY
      # Do nothing
    when X_SYMBOL
      (0..@width - 1).each do |x_val|
        @win.setpos(x_val, x_val)
        @win.addch('X')
        @win.setpos(@height - x_val - 1, x_val)
        @win.addch('X')
      end

    when O_SYMBOL
      (1..@width - 1).each do |x_val|
        @win.setpos(0, x_val)
        @win.addch('O')
        @win.setpos(@height - 1, x_val)
        @win.addch('O')
      end
      (1..@height - 1).each do |y_val|
        @win.setpos(y_val, 0)
        @win.addch('O')
        @win.setpos(y_val, @width - 1)
        @win.addch('O')
      end
    end
  end
end
