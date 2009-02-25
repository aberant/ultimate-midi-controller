class BoxWidget < Shape
  WIDTH = 80
  CENTER = 3
  BACKGROUND = [75, 75, 75]
  CURSOR = [76,	224, 230]
  CURSOR_WIDTH = 10
  
  def initialize( app, tuio_object )
    @app = app
    @x = ( tuio_object[:x_pos] * @app.width ).to_i
    @y = ( tuio_object[:y_pos] * @app.height ).to_i
  end
  
  def draw
    @app.push_matrix
      @app.rect_mode CENTER
      @app.fill *BACKGROUND
      @app.rect( @x, @y, WIDTH, WIDTH )
      if @cursor
        @app.fill *CURSOR
        @app.ellipse( @cursor[:x], @cursor[:y], CURSOR_WIDTH, CURSOR_WIDTH )
      end
    @app.pop_matrix
  end
  
private
    def handle_click( x, y )
      @cursor = {:x => x, :y => y}
        
    end
    
    def intersection?( x, y )
      half_width = WIDTH / 2
      (x >= @x - half_width && x <= @x + half_width && y >= @y - half_width && y < @y + half_width)
    end
end