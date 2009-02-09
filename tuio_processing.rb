require 'ruby-processing'
require 'world'
require 'widgets/shape'
require 'widgets/square'
require 'tuio_event'
require 'live_midi'


class MySketch < Processing::App
  load_ruby_library "control_panel"
  load_ruby_library "tuio_client"
  load_java_library "mmj"
  load_ruby_library "midiator"
  
  
  def setup
    @world = World.new(self)  
      
    @midi = LiveMidi.new
    
    @server = TUIOClient.new
    
    Thread.new do
      @server.start
    end
  end

  def draw
    draw_world
    
    trigger_world_events
    
    sleep 0.1
  end
  
  def mouse_clicked
    event = TuioEvent.new( :click, mouseX, mouseY )
    @world.click( event )
  end
  
  def midi
    @midi 
  end

private 

  def draw_world
    @server.tuio_objects.each do |session_id, tuio_object|
      @world.draw( tuio_object )
    end
  end

  def trigger_world_events
    @server.tuio_cursors.each do |session_id, tuio_cursor|
      x = ( SKETCH_WIDTH  * tuio_cursor[:x_pos] ).to_i
      y = ( SKETCH_HEIGHT * tuio_cursor[:y_pos] ).to_i
      event = TuioEvent.new(:click, x, y)
      @world.click( event )
    end
  end
  
end



MySketch.new :title => "My Sketch", :width => 200, :height => 200