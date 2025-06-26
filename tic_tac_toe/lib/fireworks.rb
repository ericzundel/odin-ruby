# frozen_string_literal: true

require 'curses'

# A celebration for the end of the game
#
# If this code seems a little weird, it's because it was written by AI (Cursor, claude) and I
# only made minor updates.
class Fireworks
  def initialize(screen)
    @screen = screen
    @main_win = screen.main_win
    @lines = Curses.lines
    @cols = Curses.cols
    @center_x = @cols / 2
    @center_y = @lines / 2
  end

  def display_winner(winner)
    clear_screen
    show_fireworks
    show_winner_message(winner)
    @screen.refresh
  end

  private

  def clear_screen
    @main_win.clear
    @main_win.refresh
  end

  def show_fireworks
    3.times do |i|
      launch_firework(i)
      sleep(0.5)
    end
  end

  def launch_firework(_firework_num)
    # Calculate random starting position for each firework
    start_x = rand(5..(@cols - 5))
    start_y = @lines - 2
    end_y = rand(5..(@lines - 4))

    # Launch rocket
    start_y.downto(end_y) do |y|
      @main_win.setpos(y, start_x)
      @main_win.addstr('|')
      @main_win.refresh
      sleep(0.01)

      # Clear previous position
      @main_win.setpos(y, start_x)
      @main_win.addstr(' ')
    end

    # Explode into shooting star pattern
    explode_firework(start_x, end_y)
  end

  def explode_firework(x, y)
    # Create shooting star pattern
    patterns = [
      # Horizontal line
      [[0, -2], [0, -1], [0, 1], [0, 2]],
      # Vertical line
      [[-2, 0], [-1, 0], [1, 0], [2, 0]],
      # Diagonal lines
      [[-2, -2], [-1, -1], [1, 1], [2, 2]],
      [[-2, 2], [-1, 1], [1, -1], [2, -2]]
    ]

    patterns.each do |pattern|
      pattern.each do |dy, dx|
        new_y = y + dy
        new_x = x + dx

        if valid_position?(new_x, new_y)
          @main_win.setpos(new_y, new_x)
          @main_win.addstr('*')
        end
      end
      @main_win.refresh
      sleep(0.1)
    end

    # Fade out
    sleep(0.5)
    patterns.each do |pattern|
      pattern.each do |dy, dx|
        new_y = y + dy
        new_x = x + dx

        if valid_position?(new_x, new_y)
          @main_win.setpos(new_y, new_x)
          @main_win.addstr(' ')
        end
      end
    end
    @main_win.refresh
  end

  def valid_position?(x, y)
    x >= 0 && x < @cols && y >= 0 && y < @lines
  end

  def show_winner_message(winner)
    # Clear center area
    center_y = @lines / 2
    center_x = @cols / 2

    # Display large winner symbol
    if winner == 'X'
      display_large_x(center_y - 2, center_x - 3)
    elsif winner == 'O'
      display_large_o(center_y - 2, center_x - 3)
    else
      display_tie_message(center_y, center_x - 5)
    end

    # Display "WINS!" message
    if winner != 'Tie'
      @main_win.setpos(center_y + 4, center_x - 3)
      @main_win.addstr('WINS!')
    end

    @main_win.refresh
  end

  def display_large_x(y, x)
    # Large X pattern
    @main_win.setpos(y, x)
    @main_win.addstr('X   X')
    @main_win.setpos(y + 1, x)
    @main_win.addstr(' X X ')
    @main_win.setpos(y + 2, x)
    @main_win.addstr('  X  ')
    @main_win.setpos(y + 3, x)
    @main_win.addstr(' X X ')
    @main_win.setpos(y + 4, x)
    @main_win.addstr('X   X')
  end

  def display_large_o(y, x)
    # Large O pattern
    @main_win.setpos(y, x)
    @main_win.addstr(' OOO ')
    @main_win.setpos(y + 1, x)
    @main_win.addstr('O   O')
    @main_win.setpos(y + 2, x)
    @main_win.addstr('O   O')
    @main_win.setpos(y + 3, x)
    @main_win.addstr('O   O')
    @main_win.setpos(y + 4, x)
    @main_win.addstr(' OOO ')
  end

  def display_tie_message(y, x)
    @main_win.setpos(y, x)
    @main_win.addstr('IT\'S A TIE!')
  end
end
