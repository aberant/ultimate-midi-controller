require 'ruby-processing'
require 'world'
require 'shape'
require 'square'

class MySketch < Processing::App
  load_ruby_library "control_panel"
  load_ruby_library "tuio_client"
  load_ruby_library "midiator"
  
  def setup
    @world = World.new(self)    

    @tc = TUIOClient.new
    
    Thread.new do
      @tc.start
    end
  end

  def draw
    @tc.tuio_objects.each do |k, v|

      @world.draw( v )

    end
    sleep 0.1
  end
  
  def mouse_clicked
    @world.click(mouseX, mouseY)
  end  

end



MySketch.new :title => "My Sketch", :width => 800, :height => 600