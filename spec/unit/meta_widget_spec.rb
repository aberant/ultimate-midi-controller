require File.dirname(__FILE__) + '/spec_helper'

describe MetaWidget do
  before :each do
    setup_stubbed_world
    tuio = { :x_pos => 0.1, :y_pos => 0.1 }
    
    @widget = MetaWidget.new( @app, tuio )
  end
  
  it_should_behave_like "basic shape"
  
  describe 'basic stuff' do
    it 'should have a title' do
      @widget.should respond_to( :title )
    end
  end
  
  describe 'contains another widget' do
    before :each do
      tuio = { :x_pos => 0.5, :y_pos => 0.5 }
      @slider = SliderWidget.new( @app, tuio )
      @box = BoxWidget.new( @app, tuio )
      
      @widget.add_widget( @slider )
      @widget.add_widget( @box )
    end
    
    it 'should be able to verify it contains other widgets' do
      @widget.widgets.include?( @slider).should be_true 
      @widget.widgets.include?( @box).should be_true
    end
    
    it 'should call draw on all the contained widgets if drawn' do
      mock( @slider ).draw
      mock( @box ).draw
      
      @widget.draw
    end
    
    it 'should be able to determine its own width from the widgets it contains' do
      @widget.my_width.should_not be_less_than( @slider.width + @box.width )  
    end
    
    it 'should be able to determine its own height from the widgets it contains' do
      @widget.my_height.should_not be_less_than( @slider.height + @box.height )  
    end
  end
end