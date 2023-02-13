class Board

  ##
  # Create a new board with all 9 slots empty as indicated by nil.
  def initialize
    @game_board = Array.new(9)
  end

  ##
  # Clear the board by resetting all 9 slots of @game_board to nil.
  def clear_board
    @game_board.clear
    puts "Cleared board."
  end

  ##
  # Set the marker at the index in the board array.
  def mark(index)

  end

  ##
  # Return the board in current state in string format.
  def get_board
    board_str = ""
    
    @game_board.each_with_index do |slot, index|
      board_str << "["
      if slot
        board_str << slot
      else
        board_str << " "
      end
      board_str << "]"

      if (index + 1) % 3 == 0
        board_str << "\n"
      end
    end

    return board_str
  end

  ##
  # Check each row for a winner and return the marker if there is one.
  # Return nil if no row has a winner.
  def check_rows
    index = 0

    while index < 9 do
      row_markers = @game_board[index..(index + 2)].uniq

      if row_markers.size == 1 && row_markers[0] != nil
        return row_markers[0]
      end

      index += 3
    end

    return nil
  end

  ##
  # Check each column for a winner and return the marker if there is one.
  # Return nil if no column has a winner.
  def check_columns
    index = 0

    while index < 3 do
      column_markers = [
        @game_board[index],
        @game_board[index + 3],
        @game_board[index + 6]
      ]
      column_markers = column_markers.uniq

      if column_markers.size == 1 && column_markers[0] != nil
        return column_markers[0]
      end
      
      index += 1
    end

    return nil
  end

  ##
  # Check both diagonals for a winner and return the marker if there is one.
  # Return nil if no diagonal has a winner.
  def check_diagonals
    diagonal_markers = [@game_board[0], @game_board[4], @game_board[8]]
    diagonal_markers = diagonal_markers.uniq

    if diagonal_markers.size == 1 && diagonal_markers[0] != nil
      return diagonal_markers[0]
    end

    diagonal_markers = [@game_board[2], @game_board[4], @game_board[6]]
    diagonal_markers = diagonal_markers.uniq

    if diagonal_markers.size == 1 && diagonal_markers[0] != nil
      return diagonal_markers[0]
    end

    return nil
  end

end