# frozen_string_literal: true

require 'curses'

require_relative './grid'
require_relative './tile'
require_relative './screen'

# Container for the entire tic tac toe board
class Board
  IN_PROGRESS = :IN_PROGRESS
  X_PLAYER = :X_PLAYER
  O_PLAYER = :O_PLAYER
  TIE = :TIE

  attr_reader :winner

  def initialize(screen)
    @screen = screen
    @grid = Grid.new(@screen.side_size)
    @tiles = Array.new(3) { Array.new(3) }
    tile_size = (@screen.side_size / 3)
    (0..2).each do |row|
      (0..2).each do |col|
        @tiles[row][col] = Tile.new(@screen.main_win, col * tile_size, row * tile_size, (@screen.side_size / 3) - 2)
      end
    end
    @grid.draw(@screen.main_win)
    @winner = IN_PROGRESS
    @next_player = X_PLAYER
  end

  # add the letter x to a tile
  def set_tile_x(x_pos, y_pos)
    raise ArgumentError, 'X should be a value 0..2' unless x_pos.between?(0, 2)
    raise ArgumentError, 'Y should be a value 0..2' unless y_pos.between?(0, 2)

    @tiles[y_pos][x_pos].value = Tile::X_SYMBOL
    calc_winner
  end

  # add the letter o to a tile
  def set_tile_o(x_pos, y_pos)
    raise ArgumentError, 'X should be a value 0..2' unless x_pos.between?(0, 2)
    raise ArgumentError, 'Y should be a value 0..2' unless y_pos.between?(0, 2)

    @tiles[y_pos][x_pos].value = Tile::O_SYMBOL
    calc_winner
  end

  # Play the turn for the next player
  def next_player_turn
    # set the cursor to the first non-empty tile
    cursor = [0, 0]
    (0..2).each do |row|
      (0..2).each do |col|
        if @tiles[row][col].value == Tile::EMPTY
          cursor = [row, col]
          break
        end
      end
    end
    selected_tile = choose_tile(cursor)

    if @next_player == X_PLAYER
      set_tile_x(selected_tile[1], selected_tile[0])
      @next_player = O_PLAYER
    else
      set_tile_o(selected_tile[1], selected_tile[0])
      @next_player = X_PLAYER
    end
  end

  private

  def choose_tile(cursor)
    loop do
      highlight_cursor(cursor)
      case @screen.main_win.getch
      when Curses::Key::UP
        cursor[0] = if cursor[0] != 0
                      cursor[0] - 1
                    else
                      2
                    end
      when Curses::Key::DOWN
        cursor[0] = (cursor[0] + 1) % 3
      when Curses::Key::LEFT
        cursor[1] = if cursor[1] != 0
                      cursor[1] - 1
                    else
                      2
                    end
      when Curses::Key::RIGHT
        cursor[1] = (cursor[1] + 1) % 3
      when ' '
        # The tile under the cursor is selected
        clear_cursor
        break
      end
      @screen.main_win.refresh
      cursor
    end
  end

  # cursor: array of row, col for which tile is selected
  def highlight_cursor(cursor)
    @tiles[cursor[0]][cursor[1]].select
  end

  def clear_cursor
    (0..2).each do |row|
      (0..2).each do |col|
        @tiles[row][col].deselect
      end
    end
  end

  def calc_winner
    return @winner if @winner != IN_PROGRESS

    # check rows
    (0..2).each do |row|
      winner = test_three_tiles([@tiles[row][0], @tiles[row][1], @tiles[row][2]])
      return winner if winner != IN_PROGRESS
    end

    # check columns
    (0..2).each do |col|
      winner = test_three_tiles([@tiles[0][col], @tiles[1][col], @tiles[2][col]])
      return winner if winner != IN_PROGRESS
    end

    # check diagonals
    winner = test_three_tiles([@tiles[0][0], @tiles[1][1], @tiles[2][2]])
    return winner if winner != IN_PROGRESS

    winner = test_three_tiles([@tiles[2][0], @tiles[1][1], @tiles[2][0]])
    return winner if winner != IN_PROGRESS

    # No winner and the board is board full? It's a tie
    (0..2).each do |row|
      (0..2).each do |col|
        return Board::IN_PROGRESS if @tiles[row][col].value == Tile::EMPTY
      end
    end
    @winner = TIE
  end

  def test_three_tiles(test_tiles)
    raise ArgumentError, 'must have 3 tiles' if test_tiles.length != 3

    if test_tiles[0].value == Tile::O_SYMBOL && test_tiles[1].value == Tile::O_SYMBOL && test_tiles[2].value == Tile::O_SYMBOL
      @winner = Board::O_PLAYER
    elsif test_tiles[0].value == Tile::X_SYMBOL && test_tiles[1].value == Tile::X_SYMBOL && test_tiles[2].value == Tile::X_SYMBOL
      @winner = Board::X_PLAYER
    else
      Board::IN_PROGRESS
    end
  end
end
