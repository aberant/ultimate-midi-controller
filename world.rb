class World
  CONFIG = { 
    0 => NextPrevWidget,
    6 => SliderWidget }
  
  def initialize( app )
    @app = app
    @things = {}
  end
  
  def draw_all( tuio_objects )
    tuio_objects.each do |session_id, tuio_object|
      draw( tuio_object )
    end
  end
  
  def click( event )
    @things.values.each do |thing|
      thing.click( event )
    end
  end
  
  def config
    CONFIG
  end
  
private 

  def draw( tuio_object )
    class_id = tuio_object[:class_id]
  
    if already_in_world?( class_id )
      @things[class_id].update( tuio_object )
    else
      @things[class_id] = CONFIG[class_id].new( @app, tuio_object )
    end
  
    @things[class_id].draw
  end

  def already_in_world?( class_id )
    @things.has_key?( class_id )
  end
end
