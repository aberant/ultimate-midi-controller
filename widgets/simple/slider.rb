require File.join( File.dirname(__FILE__), "shape")

class SliderWidget < Shape
  WIDTH = 20
  HEIGHT = 80
  CURSOR_HEIGHT = 2
  BACKGROUND = [0, 255, 0]
  CURSOR = [255, 0, 0]
  MIDI_MAX = 127
  MIDI_MIN = 0
  
  def initialize( app, tuio_object )
    @app = app
    @x = ( tuio_object[:x_pos] * @app.width ).to_i
    @y = ( tuio_object[:y_pos] * @app.height ).to_i
    @channel = tuio_object[:class_id]
    
    @angle = tuio_object[:angle]
    
    @value = 0
    @cursor = HEIGHT 
  end
  
  def draw
    @app.push_matrix
      @app.rect_mode 0
    
      @app.fill *BACKGROUND
      @app.rect( @x, @y, WIDTH, HEIGHT )
      
      @app.fill *CURSOR
      @app.rect( @x, @y + @cursor, WIDTH, CURSOR_HEIGHT )
      
    @app.pop_matrix
  end
  
  def width
    WIDTH
  end
  
  def height
    HEIGHT
  end
  
private
  def handle_click( abs_x, abs_y )
    @cursor =  abs_y - @y
    
    @value  = to_midi_value( abs_y )
    
    @app.midi.slider( @channel, @value )
  end
  
  def to_midi_value( abs_y )
    value  = (( @y + HEIGHT + 1 ) - abs_y) / HEIGHT
    return ( value * MIDI_MAX ).to_i
  end
  
  def intersection?(x, y)
    x >= @x && x <= @x + WIDTH && y >= @y && y < @y + HEIGHT
  end
  
end
