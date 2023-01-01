# frozen_string_literal: false

# Class for game board.
class Board

  @@pos_map = {
    0 => [0, 0], 1 => [0, 1], 2 => [0, 2],
    3 => [1, 0], 4 => [1, 1], 5 => [1, 2],
    6 => [2, 0], 7 => [2, 1], 8 => [2, 2]
  }

  def initialize
    reset_board()
  end

  def display_board
    board_positions = @@pos_map.values

    @board.each_with_index do |row, row_idx|
      
      row.each_with_index do |box, col_idx|
      
        if box == nil
          print "#{row_idx * 3 + col_idx} "
        else
          print "#{box} "
        end

      end

      puts
    end
    puts
  end

  # Mark the board at coordinate (x, y) that pos maps to, then return true.
  # If `pos` is out-of-bounds, return false.
  def mark(marker, pos)
    x = @@pos_map.dig(pos)[0]
    y = @@pos_map.dig(pos)[1]

    if x == nil || y == nil
      puts "Error: cannot place #{marker} on invalid position #{pos}."
      return false
    else
      @board[x][y] = marker
      return true
    end
  end

  def reset_board
    @board = Array.new(3) { Array.new(3) }
  end

  def full?
    @board.all? { |row| row.include?(nil) == false }
  end

  def winner
    @board.each_with_index do |row, row_idx|
      # Case (0, 0) -> 5 possible
      if row_idx == 0
        if row.uniq[0] != nil && row.uniq.size() == 1
          return row[0]
        end

        if row[0] != nil && row[0] == @board[1][0] && row[0] == @board[2][0]
          return row[0]
        end

        if row[1] != nil && row[1] == @board[1][1] && row[1] == @board[2][1]
          return row[1]
        end

        if row[2] != nil && row[2] == @board[1][2] && row[2] == @board[2][2]
          return row[2]
        end

        if row[0] != nil && row[0] == @board[1][1] && row[0] == @board[2][2]
          return row[0]
        end
      end

      # Case (1, 0) -> just check the current row
      if row_idx == 1
        if row.uniq[0] != nil && row.uniq.size() == 1
          return row[0]
        end
      end

      # Case (2, 0) -> check current row and diagonal going to (0, 2)
      if row_idx == 2
        if row.uniq[0] != nil && row.uniq.size() ==1
          return row[0]
        end

        if row[0] != nil && row[0] == @board[1][1] && row[0] == @board[0][2]
          return row[0]
        end
      end
    end

    return nil # no winner
  end
end
