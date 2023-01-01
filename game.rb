require_relative 'board.rb'
require_relative 'player.rb'

class Game

  @@o_marker = 'O'
  @@x_marker = 'X'

  def initialize()
    @players = []
    @board = Board.new
  end

  def start()
    puts "Tic-Tac-Toe"
    run_new_game()
  end

  def run_new_game()
    print "Enter y/Y to start a new game: "
    prompt = gets().chomp().downcase()

    print "Enter player 1 name (marker 'O'): "
    p1_name = gets().chomp()
    @players << Player.new(p1_name, @@o_marker)

    print "Enter player 2 name (marker 'X'): "
    p2_name = gets().chomp()
    @players << Player.new(p2_name, @@x_marker)

    while prompt == 'y' do
      turn = 0
      @board.display_board

      while @board.full? == false && @board.winner == nil do
        print "#{@players[turn].name}, choose a box to mark from 0 to 8: "
        pos = gets().chomp().to_i()
        @board.mark(@players[turn].marker, pos)
        @board.display_board()
        turn = (turn + 1) % 2
      end
      
      if @board.winner() == @@o_marker
        @players[0].score += 1
      elsif @board.winner() == @@x_marker
        @players[1].score += 1
      end

      @board.display_board()
      @board.reset_board()

      puts "[Score] #{@players[0].name}: #{@players[0].score}, #{@players[1].name}: #{@players[1].score}"
      print "Play again (y/Y)? "
      prompt = gets().chomp().downcase()
    end

    puts 'Good-bye'

  end

end
