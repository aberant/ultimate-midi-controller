require File.dirname(__FILE__) + '/spec_helper'

describe Mixer8Widget do
  before :each do
    setup_stubbed_world
    tuio = { :x_pos => 0.1, :y_pos => 0.1 }
    
    @widget = Mixer8Widget.new( @app, tuio )
  end
  
  it_should_behave_like "basic shape"
end