class World
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
  
private 

  def draw( tuio_object )
    class_id = tuio_object[:class_id]
  
    unless already_in_world?( class_id )
      @things[class_id] = NextPrevWidget.new( @app, tuio_object )
    end
  
    @things[class_id].draw
  end

  def already_in_world?( class_id )
    @things.has_key?( class_id )
  end
end
