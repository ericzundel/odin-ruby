# frozen_string_literal: true

# The Screen class holds all the curses state
# Note, you MUST call close before exiting if you want your terminal to return to normal
#
# begin
#   screen = Screen.new
#   main_win = screen.main_win
#   ...
# finally
#   screen.close
# end
#
class Screen
  NORMAL_COLOR = 1
  HIGHLIGHT_COLOR = 2
  attr_reader :main_win, :side_size

  def initialize
    Curses.init_screen
    Curses.start_color
    @main_win = Curses::Window.new(Curses.lines, Curses.cols, 0, 0)
    @main_win.keypad = true
    Curses.init_pair(NORMAL_COLOR, Curses::COLOR_BLACK, Curses::COLOR_YELLOW)
    Curses.init_pair(HIGHLIGHT_COLOR, Curses::COLOR_YELLOW, Curses::COLOR_BLACK)
    @side_size = [Curses.lines, Curses.cols].min
  end

  def close
    @main_win.close
  end
end
