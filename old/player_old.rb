# frozen_string_literal: false

# Class for player.
# @marker can only be 'O' or 'X'
class Player
  attr_reader :name
  attr_accessor :score, :marker

  def initialize(name, marker)
    @name = name
    @marker = marker
    @score = 0
  end
end
