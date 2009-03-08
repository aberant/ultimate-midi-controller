require File.dirname(__FILE__) + '/spec_helper'
RED = [100, 0 , 0]
BLUE = [0, 0, 100]
GREEN = [0, 100, 0]
describe NextPrevWidget do
  before :each do
    @app = Object.new
    
    stub( @app ).width   { SKETCH_WIDTH }
    stub( @app ).height  { SKETCH_HEIGHT }
    stub( @app ).push_matrix
    stub( @app ).pop_matrix
    
    rel_x, rel_y = 0.35, 0.35
    abs_x, abs_y = rel_to_abs( rel_x, rel_y )
    
    @tuio_object = { :x_pos => rel_x,
                    :y_pos => rel_y }
                    
    @widget = NextPrevWidget.new( @app, @tuio_object )
    
  end
  
  it_should_behave_like "basic shape"
  
  it 'should be able to update based on fiducial movement' do
    rel_x, rel_y = 0.36, 0.36
    abs_x, abs_y = rel_to_abs( rel_x, rel_y )
    
    tuio_update = { :x_pos => rel_x,
                    :y_pos => rel_y }
    
    @widget.update( tuio_update )
    
    @widget.location.should == [abs_x, abs_y]
  end
end