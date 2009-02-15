class World
  def initialize(app)
    @app = app
    @things = {}
  end
  
  def draw( tuio_object )
    class_id = tuio_object[:class_id]
    unless @things.has_key?( class_id )
      @things[class_id] = Square.new(@app, tuio_object)
    end
    
    @things[class_id].draw
  end
  
  def click( event )
    @things.values.each do |thing|
      thing.click( event )
    end
  end
end
