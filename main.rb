require_relative 'game.rb'

print "Enter player 1 name: "
p1_name = gets.chomp

print "Enter player 2 name: "
p2_name = gets.chomp

game = Game.new

loop do
  winner = game.start
  if winner
    puts "#{winner} wins"
  else # tie
    puts "Tie"
  end

  game.display_score

  print "Play again (y/n)? "
  break if gets.chomp == 'n'

  print "Reset score (y/n)? "
  game.reset_score if gets.chomp == 'y'

  game.reset_board
end