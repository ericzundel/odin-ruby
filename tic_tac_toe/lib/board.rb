# frozen_string_literal: true

require 'curses'

require_relative 'grid'
require_relative 'tile'
require_relative 'screen'

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

  # Add the letter x to a tile
  def set_tile_x(y_pos, x_pos)
    raise ArgumentError, 'X should be a value 0..2' unless x_pos.between?(0, 2)
    raise ArgumentError, 'Y should be a value 0..2' unless y_pos.between?(0, 2)

    tile = @tiles[y_pos][x_pos]
    raise 'Trying to set a tile that is already set!' if tile.value != Tile::EMPTY

    tile.value = Tile::X_SYMBOL
    calc_winner
  end

  # Add the letter o to a tile
  def set_tile_o(y_pos, x_pos)
    raise ArgumentError, 'X should be a value 0..2' unless x_pos.between?(0, 2)
    raise ArgumentError, 'Y should be a value 0..2' unless y_pos.between?(0, 2)

    tile = @tiles[y_pos][x_pos]
    raise 'Trying to set a tile that is already set!' if tile.value != Tile::EMPTY

    tile.value = Tile::O_SYMBOL
    calc_winner
  end

  # Play the turn for the next player
  def next_player_turn
    # set the cursor to the first non-empty tile
    cursor = find_first_empty_tile

    cursor = choose_tile(cursor)

    if @next_player == X_PLAYER
      set_tile_x(cursor[:row], cursor[:col])
      @next_player = O_PLAYER
    else
      set_tile_o(cursor[:row], cursor[:col])
      @next_player = X_PLAYER
    end
  end

  private

  def find_first_empty_tile
    (0..2).each do |row|
      (0..2).each do |col|
        return { row: row, col: col } if @tiles[row][col].value == Tile::EMPTY
      end
    end
    raise 'No empty tiles: We should have determined a winner or tie already!'
  end

  # Direction is a Curses::Key definition for one of the arrow keys
  # cursor is a hash with keys :row and :col
  def find_empty_tile(direction, cursor)
    case direction
    when Curses::Key::LEFT
      cursor[:row] = (cursor[:row] - 1) % 3
    when Curses::Key::RIGHT
      cursor[:row] = (cursor[:row] + 1) % 3
    when Curses::Key::UP
      cursor[:col] = (cursor[:col] - 1) % 3
    when Curses::Key::DOWN
      cursor[:col] = (cursor[:col] + 1) % 3
    end
    cursor
  end

  # Handle keyboard input to allow the user to choose a tile
  # returns array [row, col]
  def choose_tile(cursor)
    loop do
      highlight_cursor(cursor)
      @screen.print_status "#{@next_player}: It's your turn, use arrow keys to move, space to choose #{cursor}: "

      input = @screen.getch
      if input == ' '
        # The tile under the cursor is selected
        if @tiles[cursor[:row]][cursor[:col]].value == Tile::EMPTY
          clear_cursor
          break
        end
      else
        cursor = find_empty_tile(input, cursor)
      end
      @screen.refresh
    end
    cursor
  end

  # Highlight the tile under the cursor
  # cursor: hash of :row, :col for which tile is selected
  def highlight_cursor(cursor)
    clear_cursor
    @tiles[cursor[:row]][cursor[:col]].select
  end

  # Remove the highlight from all tiles
  def clear_cursor
    (0..2).each do |row|
      (0..2).each do |col|
        @tiles[row][col].deselect
      end
    end
  end

  # Go through the puzzle and check to see if either player has won
  def calc_winner
    return @winner if @winner != IN_PROGRESS

    # Check rows & columns
    (0..2).each do |pos|
      winner = test_three_tiles([@tiles[pos][0], @tiles[pos][1], @tiles[pos][2]])
      return winner if winner != IN_PROGRESS

      winner = test_three_tiles([@tiles[0][pos], @tiles[1][pos], @tiles[2][pos]])
      return winner if winner != IN_PROGRESS
    end

    # Check diagonals
    winner = test_three_tiles([@tiles[0][0], @tiles[1][1], @tiles[2][2]])
    return winner if winner != IN_PROGRESS

    winner = test_three_tiles([@tiles[2][0], @tiles[1][1], @tiles[0][2]])
    return winner if winner != IN_PROGRESS

    # No winner and the board is board full? It's a tie
    (0..2).each do |row|
      (0..2).each do |col|
        return Board::IN_PROGRESS if @tiles[row][col].value == Tile::EMPTY
      end
    end
    @winner = TIE
  end

  # This is a helper method for check_winner to see if three tiles are the same
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
