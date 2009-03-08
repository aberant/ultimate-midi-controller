require File.dirname(__FILE__) + '/spec_helper'

describe SliderWidget do
  before :each do
    @gui = Object.new
    stub( @gui ).width { 800 }
    stub( @gui ).height { 600 }
    
    @abs_x, @abs_y = 100, 100
    @rel_x, @rel_y = abs_to_rel( @abs_x, @abs_y )
    
    tuio_object = {
      :x_pos => @rel_x,
      :y_pos => @rel_y,
      :class_id => 1
    }
    
    @widget = SliderWidget.new( @gui, tuio_object )
    @driver = Object.new
    stub( @gui ).midi { @driver }
    
  end
  
  it_should_behave_like "basic shape"
  
  
  it "should call the gui library to draw it's self" do
    mock( @gui ).push_matrix
    
    # this means corner not center
    mock( @gui ).rect_mode( 0 ) 
    
    mock( @gui ).fill( *SliderWidget::BACKGROUND )
    mock( @gui ).rect(  @abs_x, 
                        @abs_y, 
                        SliderWidget::WIDTH, 
                        SliderWidget::HEIGHT 
                      )
                      
    mock( @gui ).fill( *SliderWidget::CURSOR )
    mock( @gui ).rect(  @abs_x, 
                        @abs_y + SliderWidget::HEIGHT, 
                        SliderWidget::WIDTH, 
                        SliderWidget::CURSOR_HEIGHT
                      )
    mock( @gui ).pop_matrix
    @widget.draw
  end
      
  it "should have the right value when clicked at the top of the slider" do
    mock( @driver ).slider( 1 , 127)
        
    @widget.send( :handle_click, @abs_x, @abs_y + 1)
  end
  
  it "should have the correct value when clicked at the bottom of the slider" do
    mock( @driver ).slider( 1 , 0)
    
    @widget.send( :handle_click, @abs_x, @abs_y + SliderWidget::HEIGHT )
  end
  
  it "should not care about things clicked beyond the slider" do
    @widget.send(:intersection?, @abs_x, @abs_y + SliderWidget::HEIGHT + 10 ).should be_false
  end
  
end