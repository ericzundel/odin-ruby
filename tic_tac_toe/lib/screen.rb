# frozen_string_literal: true

require 'curses'

# The Screen class holds all the curses state
# Note, you MUST call close before exiting if you want your terminal to return to normal
#
# begin
#   screen = Screen.new
#   ...
# ensure
#   screen.close
# end
#
class Screen
  NORMAL_COLOR = 1
  HIGHLIGHT_COLOR = 2
  CURSOR_COLOR = 3
  attr_reader :main_win, :side_size

  def initialize
    Curses.init_screen
    Curses.start_color
    @main_win = Curses::Window.new(Curses.lines, Curses.cols, 0, 0)
    @main_win.keypad = true
    Curses.init_pair(HIGHLIGHT_COLOR, Curses::COLOR_BLACK, Curses::COLOR_YELLOW)
    Curses.init_pair(NORMAL_COLOR, Curses::COLOR_YELLOW, Curses::COLOR_BLACK)
    Curses.init_pair(CURSOR_COLOR, Curses::COLOR_BLUE, Curses::COLOR_YELLOW)
    @side_size = [Curses.lines, Curses.cols].min
  end

  def print_status(status)
    @main_win.setpos(Curses.lines - 1, 0)
    @main_win.addstr(status)
    @main_win.clrtoeol
    @main_win.refresh
  end

  def getch
    @main_win.getch
  end

  def refresh
    @main_win.refresh
  end

  # Call this method before ending the program to restore the screen
  def close
    @main_win.close
  end
end
