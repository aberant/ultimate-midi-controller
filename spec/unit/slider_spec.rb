require File.dirname(__FILE__) + '/spec_helper'
require 'widgets/slider'

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
    
    @slider = SliderWidget.new( @gui, tuio_object )
    @driver = Object.new
    stub( @gui ).midi { @driver }
    
  end
  
  it "should be able to draw it self" do
    @slider.should respond_to( :draw )
  end
  
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
                      
    mock( @gui ).fill( *SliderWidget::BAR )
    mock( @gui ).rect(  @abs_x, 
                        @abs_y + SliderWidget::HEIGHT, 
                        SliderWidget::WIDTH, 
                        SliderWidget::BAR_HEIGHT
                      )
    mock( @gui ).pop_matrix
    @slider.draw
  end
      
  it "should have the right value when clicked at the top of the slider" do
    mock( @driver ).slider( 1 , 127)
        
    @slider.send( :handle_click, @abs_x, @abs_y + 1)
  end
  
  it "should have the correct value when clicked at the bottom of the slider" do
    mock( @driver ).slider( 1 , 0)
    
    @slider.send( :handle_click, @abs_x, @abs_y + SliderWidget::HEIGHT )
  end
  
  it "should not care about things clicked beyond the slider" do
    @slider.send(:intersection?, @abs_x, @abs_y + SliderWidget::HEIGHT + 10 ).should be_false
  end
  
end