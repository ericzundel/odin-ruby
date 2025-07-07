# frozen_string_literal: true

require 'curses'

require './lib/board'
require './lib/curses_ui'

begin
  board = Board.new
  ui = CursesUi.new(board)
  ui.refresh
ensure
  ui.close
end
