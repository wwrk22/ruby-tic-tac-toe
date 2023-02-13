require_relative 'player.rb'
require_relative 'board.rb'

class Game

  def initialize(p1_name='Player 1', p2_name='Player 2')
    @p1 = Player.new(p1_name, Player.o_marker)
    @p2 = Player.new(p2_name, Player.x_marker)
    @board = Board.new
  end

  ##
  # Display the current score.
  def display_score
    puts "Score\n#{@p1.name}: #{@p1.score}\n#{@p2.name}: #{@p2.score}"
  end

  ##
  # Reset score to zero for both players.
  def reset_score
    @p1.reset_score
    @p2.reset_score
  end

  ##
  # Start a new game that runs until game is over.
  def start

  end

  ##
  # Check the board to see if the game is over by calling all #check_...
  # methods of Board.
  def game_over?
    return @board.check_rows || @board.check_columns || @board.check_diagonals
  end

end