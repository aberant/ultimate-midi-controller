class TuioEvent
  attr_reader :type, :x, :y
  
  def initialize(type, x, y)
    @type, @x, @y = type, x, y
  end
end