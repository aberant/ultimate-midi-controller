require File.dirname(__FILE__) + '/spec_helper'

describe WidgetConfig do
  before :each do
    @config = WidgetConfig.new
  end
  
  it "should be able to register keys and classes" do
    @config.should respond_to(:register)
  end
  
  it "should return a class if a value was registered for that key" do
    @config.register( 1, BoxWidget )
    @config.fetch( 1 ).should == BoxWidget
  end
  
  it "should know if a key was defined" do
    @config.register( 1, BoxWidget )
    @config.has_key?( 1 ).should == true
    @config.has_key?( 2 ).should == false
  end
  
  it "should allow you to map a single value with dsl" do
    pending
    @config.map_widgets do
      1.is BoxWidget
    end
    
    @config.fetch( 1 ).should == BoxWidget
  end
end