class Player

  @@o_marker = 'O'
  @@x_marker = 'X'

  attr_reader :name
  attr_accessor :score, :marker

  def initialize(name, marker = @@o_marker)
    @name = name
    @marker = marker
    @score = 0
  end

  public
  def Player.o_marker
    @@o_marker
  end

  def Player.x_marker
    @@x_marker
  end

end