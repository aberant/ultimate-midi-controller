require File.dirname(__FILE__) + '/spec_helper'
RED = [100, 0 , 0]
BLUE = [0, 0, 100]
GREEN = [0, 100, 0]
describe Square do
  it "should be drawn using transforms" do
    app = Object.new
    
    # 0.35 is just a random spot, no significance
    rel_x, rel_y = 0.35, 0.35
    abs_x, abs_y = rel_to_abs( rel_x, rel_y )
    
    
    stub( app ).width   { SKETCH_WIDTH }
    stub( app ).height  { SKETCH_HEIGHT }
    
    mock( app ).fill *RED
    mock( app ).rect abs_x, 
                     abs_y, 
                     Square::WIDTH, 
                     Square::WIDTH
                     
    mock( app ).fill *BLUE                    
    mock( app ).rect abs_x + Square::WIDTH, 
                     abs_y, 
                     Square::WIDTH, 
                     Square::WIDTH
                     
    mock( app ).fill *GREEN                   
    mock( app ).rect abs_x + Square::WIDTH * 2, 
                     abs_y, 
                     Square::WIDTH, 
                     Square::WIDTH
    
    tuio_object = { :x_pos => rel_x,
                    :y_pos => rel_y }
                    
    @square = Square.new( app, tuio_object )
    
    @square
    
    @square.draw
  end
end