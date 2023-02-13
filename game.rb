require_relative 'player.rb'
require_relative 'board.rb'

class Game

  def initialize(p1_name='Player 1', p2_name='Player 2')
    @p1 = Player.new(p1_name, Player.o_marker)
    @p2 = Player.new(p2_name, Player.x_marker)
    @board = Board.new
  end

  ##
  # Start a new game and run until there is a winner.
  # At the end of the game, return the winner if there is one or nil if the
  # game ends in a tie.
  def start
    loop do
      winner = play_turn(@p1)
      
      if winner
        @p1.add_one_to_score
        return @p1.name
      end
      
      winner = play_turn(@p2)
      
      if winner
        @p2.add_one_to_score
        return @p2.name
      end
    end
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
  # Play a turn for the given player. If the player wins after the turn then
  # return the player's marker. Otherwise, return nil to indicate the move
  # did not trigger a win.
  def play_turn(player)
    play_index = player.make_move
    @board.mark(play_index, player.marker)
    puts @board.get_board
    return get_winner
  end

  ##
  # Check the board to see if the game is over by calling all #check_...
  # methods of Board.
  def get_winner
    return @board.check_rows || @board.check_columns || @board.check_diagonals
  end

end