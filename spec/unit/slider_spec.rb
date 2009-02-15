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
  end
  
  it "should be able to draw it self" do
    @slider.should respond_to( :draw )
  end
  
  it "should call the gui library to draw it's self" do
    mock( @gui ).rect( @abs_x, @abs_y, SliderWidget::WIDTH, SliderWidget::HEIGHT )
    @slider.draw
  end
      
  it "should have the right value when clicked at the top of the slider" do
    driver = Object.new
    stub( driver ).slider( 1 , 127)
    
    stub( @gui ).midi { driver }
    @slider.send( :handle_click, @abs_x, @abs_y + 1)
  end
  
  it "should have the correct value when clicked at the bottome of the slider" do
    driver = Object.new
    stub( driver ).slider( 1 , 0)
    
    stub( @gui ).midi { driver }
    @slider.send( :handle_click, @abs_x, @abs_y + SliderWidget::HEIGHT )
  end
  
  it "should not care about things clicked beyond the slider" do
    @slider.send(:intersection?, @abs_x, @abs_y + SliderWidget::HEIGHT + 10 ).should be_false
  end
  
end