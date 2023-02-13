class Player

  @@o_marker = 'O'
  @@x_marker = 'X'
  @@valid_moves = "012345678"

  attr_reader :name
  attr_reader :marker
  attr_reader :score

  ##
  # Creates a new shape described by a name and a marker that must be 'O' or
  # 'X'.
  #
  # An ArgumentError is raised if the marker is not an 'O' or an 'X'.
  def initialize(name, marker)
    if marker != @@o_marker && marker != @@x_marker
      raise ArgumentError.new("Marker must be 'O' or 'X'")
    end

    @name = name
    @marker = marker
    @score = 0
  end


  ##
  # Continuously prompts player for an input until a valid one in the range of
  # 0 to 8 is given, then returns it as an integer.
  def make_move
    loop do
      print "#{@name}, make a move. Choose from 0 to 8: "
      input = gets.chomp.to_i
      return input if (0 <= input) && (input <= 8)
    end
  end


  ##
  # Increment score by one.
  def add_one_to_score
    @score += 1
  end

  ##
  # Reset score to zero.
  def reset_score
    @score = 0
  end


  class << self

    def o_marker
      @@o_marker
    end

    def x_marker
      @@x_marker
    end

  end

end