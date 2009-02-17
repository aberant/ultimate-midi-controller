require 'ruby-processing'
require 'widgets/shape'
require 'widgets/next_prev'
require 'widgets/slider'
require 'tuio_event'
require 'live_midi'
require 'world'


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
    blank_background
    
    @world.draw_all @server.tuio_objects
    
    @world.click_all( @server.tuio_cursors )
    
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
  def blank_background
    background(255)
  end
end



MySketch.new :title => "My Sketch", :width => 200, :height => 200