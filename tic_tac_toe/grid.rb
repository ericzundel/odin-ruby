# frozen_string_literal: true

# Draws the Tic Tac Toe grid on the screen
class Grid
  def initialize(side_size)
    @side_size = side_size
    @vertical_line_left = side_size / 3
    @vertical_line_right = 2 * side_size / 3
    @top_line = side_size / 3
    @bottom_line = 2 * side_size / 3
  end

  def draw(win)
    win.setpos(@top_line, 0)
    draw_horiz_line(win)
    win.setpos(@bottom_line, 0)
    draw_horiz_line(win)

    win.setpos(@vertical_line_left, 0)
    draw_vertical_line(win, @vertical_line_left)
    win.setpos(@vertical_line_right, 0)
    draw_vertical_line(win, @vertical_line_right)
  end

  private

  def draw_horiz_line(win)
    (0..@side_size).each do |x_pos|
      if [@vertical_line_left, @vertical_line_right].include?(x_pos)
        win.addch('+')
      else
        win.addch('-')
      end
    end
  end

  def draw_vertical_line(win, x_pos)
    (0..@side_size).each do |y_pos|
      win.setpos(y_pos, x_pos)
      if [@top_line, @bottom_line].include?(y_pos)
        win.addch('+')
      else
        win.addch('|')
      end
    end
  end
end
