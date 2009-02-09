require File.dirname(__FILE__) + '/spec_helper'
RED = [100, 0 , 0]
describe Square do
  it "should be drawn using transforms" do
    pending
    app = Object.new
    tuio_object = { :x_pos => 10,
                    :y_pos => 10 }
    
    stub( app ).width   { 800 }
    stub( app ).height  { 600 }
    
    mock( app ).fill *RED
    mock( app ).rect
    
    @square = Square.new( app, tuio_object )
    
    @square
    
    @square.draw
  end
end