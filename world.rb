require 'widget_config'

widgets = File.join( File.dirname(__FILE__), "widgets", "*")
Dir[widgets].each do |w|
  require  w 
end


class World
 
  def initialize( app )
    @app = app
    @things = {}
    
    @config = WidgetConfig.new
    @config.register( 0, NextPrevWidget )
    @config.register( 6, SliderWidget )
    @config.register( 24, BoxWidget )
    @config.register( 30, MetaWidget )
  end
  
  def draw_all( tuio_objects )
    tuio_objects.each do |session_id, tuio_object|
      draw( tuio_object )
    end
  end

  def click_all( tuio_cursors )
    tuio_cursors.each do |session_id, tuio_cursor|
      x = ( @app.width  * tuio_cursor[:x_pos] ).to_i
      y = ( @app.height * tuio_cursor[:y_pos] ).to_i
      
      event = TuioEvent.new(:click, x, y)
      click( event )
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
  
    if already_in_world?( class_id )
      @things[class_id].update( tuio_object )
    else
      widget = @config.fetch( class_id )
      @things[class_id] = widget.new( @app, tuio_object ) if widget
    end
  
    @things[class_id].draw
  end

  def already_in_world?( class_id )
    @things.has_key?( class_id )
  end
end
