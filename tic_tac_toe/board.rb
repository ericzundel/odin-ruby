# frozen_string_literal: true

require_relative './grid'
require_relative './tile'

# Container for the entire tic tac toe board
class Board
  IN_PROGRESS = :IN_PROGRESS
  X_PLAYER = :X_PLAYER
  O_PLAYER = :O_PLAYER
  TIE = :TIE

  attr_reader :winner

  def initialize(main_win, side_size)
    @grid = Grid.new(side_size)
    @tiles = Array.new(3) { Array.new(3) }
    tile_size = (side_size / 3) - 2
    (0..2).each do |row|
      (0..2).each do |col|
        @tiles[row][col] = Tile.new(main_win, col * tile_size, row * tile_size, (side_size / 3) - 2)
      end
    end
    @grid.draw(main_win)
    @winner = IN_PROGRESS
  end

  def set_tile_x(x_pos, y_pos)
    raise ArgumentError, 'X should be a value 0..2' unless x_pos.between?(0, 2)
    raise ArgumentError, 'Y should be a value 0..2' unless y_pos.between?(0, 2)

    @tiles[y_pos][x_pos].value = Tile::X_SYMBOL
    calc_winner
  end

  def set_tile_o(x_pos, y_pos)
    raise ArgumentError, 'X should be a value 0..2' unless x_pos.between?(0, 2)
    raise ArgumentError, 'Y should be a value 0..2' unless y_pos.between?(0, 2)

    @tiles[y_pos][x_pos].value = Tile::O_SYMBOL
    calc_winner
  end

  private

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
