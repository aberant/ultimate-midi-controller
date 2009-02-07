class World
  def initialize(app)
    @app = app
    @things = {}
  end
  
  def draw( tuio_object )
    thing = Square.new(@app, tuio_object)
    @things[tuio_object[:class_id]] = thing
    thing.draw
  end
  
  def click( event )
    @things.values.each do |thing|
      thing.click( event )
    end
  end
end
