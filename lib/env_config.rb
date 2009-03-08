widgets = File.join( APP_ROOT, "core_ext", "*")

Dir[widgets].each do |w|
  require  w 
end


class EnvConfig 
  
  class << self
    def create_config( &blk )
      clear_all
      blk.call
      create_instance
    end

    def add_config( key, value )
      @rules[key] = value
    end
        
  private # class methods
    
    def clear_all
      @rules = {}
    end

    def create_instance
      config = EnvConfig.new
      @rules.each do | key, value |
        config.register( key, value )
      end
      
      return config
    end
    
  end # metaclass
  
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