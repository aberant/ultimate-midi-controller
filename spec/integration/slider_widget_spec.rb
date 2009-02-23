require File.dirname(__FILE__) + '/spec_helper'

describe "slider widget" do
  
  before :each do
    setup_server
    
    setup_stubbed_world
    
    setup_midi
  end
  
  it "should send a higer value midi command when clicked at the top" do
    create_slider_widget
    click_at_the_top_of_the_slider_widget
    draw_world
    
    mock( @midi ).slider( Slider_ID, SliderWidget::MIDI_MAX)
    
    trigger_world_events
  end
  
  it "should send a lower value midi command when clicked at the bottom" do
    create_slider_widget
    click_at_the_bottom_of_the_slider_widget
    draw_world
    
    mock( @midi ).slider( Slider_ID, SliderWidget::MIDI_MIN)
    
    trigger_world_events
  end
  
end