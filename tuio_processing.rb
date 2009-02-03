require 'ruby-processing'
require 'library/osc-0.1.4/lib/osc'
require 'library/tuio_client'
require 'library/midiator/lib/midiator'
require 'world'

class MySketch < Processing::App

  load_java_library "mmj"
  load_ruby_library "control_panel"
  
  def setup
    # control_panel do |c|
    #   c.menu(:channel, *0..16)
    # 
    # end
    
    # @midi = MIDIator::Interface.new
    # @midi.autodetect_driver

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