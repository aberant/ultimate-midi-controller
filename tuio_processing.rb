require 'ruby-processing'
require 'library/osc-0.1.4/lib/osc'
require 'library/tuio_client'
require 'library/midiator/lib/midiator'

class MySketch < Processing::App
  
  def setup
    @midi = MIDIator::Interface.new
    @midi.autodetect_driver
    
    @tc = TUIOClient.new
    
    Thread.new do
      @tc.start
    end
  end

  def draw
    @tc.tuio_objects.each do |k, v|
      x = (width  * v[:x_pos]).to_i
      y = (height * v[:y_pos]).to_i
      size = v[:angle] * 25
      fill( size  )
      rect( x, y, size, size )
    end
    sleep 0.1
  end

end

MySketch.new :title => "My Sketch", :width => 800, :height => 600