class EvnConfig 
  def initialize
    @map = {}
  end
  
  def register( key, value )
    @map[key] = value
  end
  
  def fetch( key )
    @map[key]
  end
  
  def has_key?( key )
    @map.has_key?( key )
  end
end

=begin
  # config dsl idea
  @config = Config.map_widgets do {
    6.is SliderWidget
    0.is NextPrevWidget
    2.to.3.are BoxWidget
    4.5.7.and.9.are NextPrevWidget
  }
=end