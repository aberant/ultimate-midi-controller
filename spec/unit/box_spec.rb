require File.dirname(__FILE__) + '/spec_helper'

describe BoxWidget do
  before :each do
    setup_stubbed_world
    setup_midi
    
    @tuio_object = object_0_hash
    
    @widget = BoxWidget.new( @app, @tuio_object )
  end
  
  it_should_behave_like "basic shape"
  
  it 'should call the box function on the midi interface when clicked' do
    x = 100
    y = 100
    height = BoxWidget::HEIGHT
    width = BoxWidget::WIDTH
    
    mock( @midi ).box( @tuio_object[:class_id], x, y, width, height )
    
    @widget.send( :handle_click, x, y )
  end
end