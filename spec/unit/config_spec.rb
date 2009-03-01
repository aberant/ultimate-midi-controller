require File.dirname(__FILE__) + '/spec_helper'

describe EnvConfig do
  before :each do
    @config = EnvConfig.new
  end
  describe "basic stuff" do
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
  end
  
  describe 'config dsl' do
    it 'should be able to assign one key to one class' do
      @config = EnvConfig.create_config do
        1.is NextPrevWidget
      end
      
      @config.fetch( 1 ).should == NextPrevWidget
    end
    
    it 'should be able to use the dsl for multiple config parameters' do
      @config = EnvConfig.create_config do
        1.is NextPrevWidget
        2.is BoxWidget
      end
      
      @config.fetch( 1 ).should == NextPrevWidget
      @config.fetch( 2 ).should == BoxWidget
    end
  end
end