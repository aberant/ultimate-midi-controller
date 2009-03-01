require File.dirname(__FILE__) + '/spec_helper'


describe MetaWidget do
  before :each do
    setup_stubbed_world
    
    @meta = MetaWidget.new
  end
  
  describe 'basic stuff' do
    before :each do
      tuio = { :x_pos => 0.5, :y_pos => 0.5 }
      @slider = SliderWidget.new( @app, tuio )
      @box = BoxWidget.new( @app, tuio )
    end
    
    it 'should be able to contain other widgets' do
      @meta.add_widget( @slider )
      @meta.add_widget( @box )
      @meta.widgets.include?( @slider).should be_true 
      @meta.widgets.include?( @box).should be_true
    end
  
    it 'should have a title' do
      @meta.should respond_to( :title )
    end
  end
  
end