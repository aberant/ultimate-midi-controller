require File.dirname(__FILE__) + '/spec_helper'

describe MetaWidget do
  before :each do
    setup_stubbed_world
    tuio = { :x_pos => 0.1, :y_pos => 0.1 }
    
    @meta = MetaWidget.new( @app, tuio )
  end
  
  describe 'basic stuff' do
    it 'should have a title' do
      @meta.should respond_to( :title )
    end
    
    it 'should implement draw' do
      @meta.should respond_to( :draw )
    end
    
    it 'should implement update' do
      @meta.should respond_to( :update )
    end
  end
  
  describe 'contains another widget' do
    before :each do
      tuio = { :x_pos => 0.5, :y_pos => 0.5 }
      @slider = SliderWidget.new( @app, tuio )
      @box = BoxWidget.new( @app, tuio )
      
      @meta.add_widget( @slider )
      @meta.add_widget( @box )
    end
    
    it 'should be able to verify it contains other widgets' do
      @meta.widgets.include?( @slider).should be_true 
      @meta.widgets.include?( @box).should be_true
    end
    
    it 'should call draw on all the contained widgets if drawn' do
      mock( @slider ).draw
      mock( @box ).draw
      
      @meta.draw
    end
    
    it 'should be able to determine its own width from the widgets it contains' do
      @meta.my_width.should_not be_less_than( @slider.width + @box.width )  
    end
    
    it 'should be able to determine its own height from the widgets it contains' do
      @meta.my_height.should_not be_less_than( @slider.height + @box.height )  
    end
  end
end